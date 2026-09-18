import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/mlkit_text.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _oldPasswordFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Trạng thái kiểm tra tiêu chí bảo mật mật khẩu mới
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
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _unFocusAll() {
    _oldPasswordFocusNode.unfocus();
    _newPasswordFocusNode.unfocus();
    _confirmPasswordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unFocusAll,
      child: AppScaffold(
        title: 'Đổi mật khẩu',
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
                  'Vui lòng nhập mật khẩu hiện tại và tạo mật khẩu mới an toàn hơn cho tài khoản của bạn.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grayColor,
                  ),
                ),
                const SizedBox(height: 24),

                // 1. Mật khẩu hiện tại
                CustomTextField(
                  label: 'Mật khẩu hiện tại',
                  hintText: 'Nhập mật khẩu hiện tại',
                  controller: _oldPasswordController,
                  focusNode: _oldPasswordFocusNode,
                  obscureText: _obscureOldPassword,
                  isPassword: true,
                  onTogglePassword: () {
                    setState(() {
                      _obscureOldPassword = !_obscureOldPassword;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu hiện tại';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 2. Mật khẩu mới
                CustomTextField(
                  label: 'Mật khẩu mới',
                  hintText: 'Nhập mật khẩu mới',
                  controller: _newPasswordController,
                  focusNode: _newPasswordFocusNode,
                  obscureText: _obscureNewPassword,
                  isPassword: true,
                  onTogglePassword: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
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
                      return 'Mật khẩu mới chưa đáp ứng đủ tiêu chí bảo mật';
                    }
                    if (value == _oldPasswordController.text) {
                      return 'Mật khẩu mới phải khác mật khẩu hiện tại';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 3. Xác nhận mật khẩu mới
                CustomTextField(
                  label: 'Xác nhận mật khẩu mới',
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
                      return 'Vui lòng xác nhận lại mật khẩu mới';
                    }
                    if (value.trim() != _newPasswordController.text.trim()) {
                      return 'Mật khẩu xác nhận chưa khớp với mật khẩu mới';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Khối hiển thị tiêu chí bảo mật mật khẩu mới thời gian thực
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MlKitText(
                      'Yêu cầu độ mạnh mật khẩu mới:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontFamily: 'Itim',
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

                // Nút Cập nhật mật khẩu
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
                        // Xử lý gọi API đổi mật khẩu thành công tại đây
                        Navigator.pop(context);
                      }
                    },
                    child: const MlKitText(
                      'CẬP NHẬT MẬT KHẨU',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Itim',
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
              fontFamily: 'Itim',
              color: isMet ? AppColors.primaryColor : Colors.grey.shade600,
              fontWeight: isMet ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}