import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/mlkit_text.dart';
import 'login_screen.dart'; // Quay về màn đăng nhập sau khi đổi thành công

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Trạng thái kiểm tra tiêu chí bảo mật mật khẩu
  bool _hasLength = false;
  bool _hasUpperCase = false;
  bool _hasLowerCase = false;
  bool _hasSpecialChar = false;

  void _validatePasswordCriteria(String value) {
    setState(() {
      _hasLength = value.length >= 6 && value.length <= 19;
      _hasUpperCase = value.contains(RegExp(r'[A-Z]'));
      _hasLowerCase = value.contains(RegExp(r'[a-z]'));
      _hasSpecialChar = value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _unFocusAll() {
    _passwordFocusNode.unfocus();
    _confirmPasswordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unFocusAll,
      child: AppScaffold(
        title: 'Đặt lại mật khẩu',
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
                  'Vui lòng tạo mật khẩu mới cho tài khoản của bạn. Đảm bảo mật khẩu đáp ứng đủ tiêu chuẩn bảo mật.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: AppColors.grayColor),
                ),
                const SizedBox(height: 24),

                // Ô nhập Mật khẩu mới
                CustomTextField(
                  label: 'Mật khẩu mới',
                  hintText: 'Tạo mật khẩu bảo mật',
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: _obscurePassword,
                  isPassword: true,
                  onTogglePassword: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  onChanged: _validatePasswordCriteria,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu mới';
                    }
                    if (!_hasLength ||
                        !_hasUpperCase ||
                        !_hasLowerCase ||
                        !_hasSpecialChar) {
                      return 'Mật khẩu chưa đáp ứng đủ tiêu chí bảo mật';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Ô nhập Xác nhận mật khẩu mới
                CustomTextField(
                  label: 'Xác nhận mật khẩu',
                  hintText: 'Nhập lại mật khẩu mới',
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocusNode,
                  obscureText: _obscureConfirmPassword,
                  isPassword: true,
                  onTogglePassword: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng xác nhận lại mật khẩu';
                    }
                    if (value.trim() != _passwordController.text.trim()) {
                      return 'Mật khẩu xác nhận chưa khớp';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Khối hiển thị thời gian thực các tiêu chí bảo mật mật khẩu
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MlKitText(
                      'Yêu cầu độ mạnh mật khẩu:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildRequirementRow(
                      'Độ dài từ 6 đến 19 ký tự',
                      _hasLength,
                    ),
                    _buildRequirementRow(
                      'Có chứa ít nhất 1 chữ hoa (A-Z)',
                      _hasUpperCase,
                    ),
                    _buildRequirementRow(
                      'Có chứa ít nhất 1 chữ thường (a-z)',
                      _hasLowerCase,
                    ),
                    _buildRequirementRow(
                      'Có chứa ít nhất 1 ký tự đặc biệt (!@#\$...)',
                      _hasSpecialChar,
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Nút Hoàn tất
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
                        // Thông báo thành công và quay về màn hình Login
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đổi mật khẩu thành công!'),
                          ),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: const MlKitText(
                      'HOÀN TẤT',
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

  Widget _buildRequirementRow(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isMet ? AppColors.primaryColor : Colors.grey,
          ),
          const SizedBox(width: 8),
          MlKitText(
            text,
            style: TextStyle(
              fontSize: 12,

              color: isMet ? AppColors.primaryColor : Colors.grey.shade600,
              fontWeight: isMet ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
