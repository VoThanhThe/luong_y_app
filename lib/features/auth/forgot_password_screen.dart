import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/mlkit_text.dart';
import 'verify_otp_screen.dart'; // Import màn hình OTP tiếp theo

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _unFocusAll() {
    _phoneFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unFocusAll,
      child: AppScaffold(
        title: 'Quên mật khẩu',
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
                  'Vui lòng nhập số điện thoại đã đăng ký tài khoản của bạn để nhận mã xác thực khôi phục mật khẩu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: AppColors.grayColor),
                ),
                const SizedBox(height: 24),

                // Ô nhập Số điện thoại
                CustomTextField(
                  label: 'Số điện thoại',
                  hintText: 'Nhập số điện thoại của bạn',
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    if (value.length < 10) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Nút Tiếp tục -> Chuyển sang màn hình VerifyOtpScreen
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Chuyển sang màn hình xác thực OTP và truyền kèm số điện thoại
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyOtpScreen(
                              phoneNumber: _phoneController.text.trim(),
                            ),
                          ),
                        );
                      }
                    },
                    child: const MlKitText(
                      'TIẾP TỤC',
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
