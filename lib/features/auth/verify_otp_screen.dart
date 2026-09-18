import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/mlkit_text.dart';
import 'reset_password_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyOtpScreen({super.key, required this.phoneNumber});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();

  String _generatedOtp = '';

  @override
  void initState() {
    super.initState();
    // Tự động tạo và gửi mã OTP lần đầu khi vừa vào màn hình sau 1 giây
    Future.delayed(const Duration(milliseconds: 800), () {
      _sendNewOtpAndShowToast();
    });
  }

  // Hàm tạo 6 số ngẫu nhiên và hiển thị Toast từ trên xuống
  void _sendNewOtpAndShowToast() {
    final random = Random();
    // Random 6 chữ số từ 100000 đến 999999
    _generatedOtp = (100000 + random.nextInt(900000)).toString();

    // Hiển thị Toast trượt từ trên xuống
    _showTopToast(context, 'Mã OTP của bạn là: $_generatedOtp');
  }

  // Widget hiển thị Toast từ trên xuống
  void _showTopToast(BuildContext context, String message) {
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: -50.0, end: 0.0),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sms_rounded,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const MlKitText(
                          'Tin nhắn mới từ Tổng đài',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                        const SizedBox(height: 2),
                        MlKitText(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Nút bấm mô phỏng tính năng tự động bắt SMS (Auto-fill)
                  TextButton(
                    onPressed: () {
                      // Tự động điền mã vào ô nhập
                      _otpController.text = _generatedOtp;
                      overlayEntry?.remove();
                      // Tự động kiểm tra và chuyển màn hình luôn
                      _verifyAndNavigate();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: MlKitText(
                      'Điền nhanh',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Chèn vào Overlay của app
    Overlay.of(context).insert(overlayEntry);

    // Tự động ẩn toast sau 4 giây nếu người dùng không bấm gì
    Future.delayed(const Duration(seconds: 4), () {
      try {
        overlayEntry?.remove();
      } catch (_) {}
    });
  }

  void _verifyAndNavigate() {
    if (_formKey.currentState!.validate()) {
      if (_otpController.text.trim() == _generatedOtp) {
        // Đúng mã -> Chuyển sang màn hình đặt lại mật khẩu mới
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mã OTP không chính xác. Vui lòng thử lại!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _otpFocusNode.unfocus(),
      child: AppScaffold(
        title: 'Xác thực mã OTP',
        isShowBackButton: true,
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MlKitText(
                  'Mã xác thực (OTP) đã được gửi qua tin nhắn SMS đến số điện thoại\n${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: AppColors.grayColor),
                ),
                const SizedBox(height: 24),

                // Ô nhập mã OTP
                CustomTextField(
                  label: 'Mã OTP',
                  hintText: 'Nhập mã gồm 6 chữ số',
                  controller: _otpController,
                  focusNode: _otpFocusNode,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // Khi người dùng nhập đủ 6 số, tự động kiểm tra luôn
                    if (value.length == 6) {
                      _verifyAndNavigate();
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mã OTP';
                    }
                    if (value.length < 6) {
                      return 'Mã OTP phải gồm 6 chữ số';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Gửi lại mã
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MlKitText(
                      'Không nhận được mã? ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Tạo lại mã mới và hiển thị lại Toast
                        _sendNewOtpAndShowToast();
                      },
                      child: MlKitText(
                        'Gửi lại',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Nút Xác thực
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _verifyAndNavigate,
                    child: const MlKitText(
                      'XÁC THỰC',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,

                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
