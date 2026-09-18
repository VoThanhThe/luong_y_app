import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/mlkit_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _phoneFocusNode = FocusNode();
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
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _unFocusAll() {
    _phoneFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _confirmPasswordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _unFocusAll(),
      child: AppScaffold(
        title: 'Tạo tài khoản mới',
        isShowBackButton: true,
        backgroundColor: AppColors.grayLightColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MlKitText(
                  'Đăng ký tài khoản sẽ giúp quý khách sử dụng được đầy đủ các tính năng của bệnh viện Hoàn Mỹ\nThông tin cá nhân của quý khách được bảo mật',
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
                const SizedBox(height: 16),

                // Ô nhập Mật khẩu
                CustomTextField(
                  label: 'Mật khẩu',
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
                      return 'Vui lòng nhập mật khẩu';
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

                // Ô nhập Lại Mật khẩu
                CustomTextField(
                  label: 'Xác Nhận Mật khẩu',
                  hintText: 'Nhập lại mật khẩu',
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocusNode,
                  obscureText: _obscureConfirmPassword,
                  isPassword: true,
                  onTogglePassword: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  onChanged: (t) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng xác nhận lại mật khẩu';
                    }
                    // Đã sửa: Kiểm tra nếu khác với mật khẩu chính thì báo lỗi
                    if (value.trim() != _passwordController.text.trim()) {
                      return 'Mật khẩu xác nhận chưa chính xác';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Khối hiển thị thời gian thực các tiêu chí bảo mật mật khẩu
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MlKitText(
                        'Yêu cầu độ mạnh mật khẩu:',
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
                ),
                const SizedBox(height: 24),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text:
                            'Bằng cách nhấn nút Đăng Ký, tôi xác nhận đã đọc và đồng ý các ',
                        style: TextStyle(color: AppColors.grayColor),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Xử lý khi bấm vào Điều khoản
                            print('Đã bấm Điều khoản');
                          },
                        text: 'Điều khoản, Điều kiện',
                        style: TextStyle(color: AppColors.blackColor, decoration: TextDecoration.underline,),
                      ),
                      TextSpan(
                        text: ' sử dụng và ',
                        style: TextStyle(color: AppColors.grayColor),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Xử lý khi bấm vào Điều khoản
                            print('Đã bấm Điều khoản');
                          },
                        text: 'Chính sách bảo mật',
                        style: TextStyle(color: AppColors.blackColor, decoration: TextDecoration.underline,),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Nút Đăng ký
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (_phoneController.text.trim().isNotEmpty &&
                              _passwordController.text.trim().isNotEmpty &&
                              _confirmPasswordController.text.trim().isNotEmpty)
                          ? AppColors.primaryColor
                          : AppColors.grayColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed:
                        (_phoneController.text.trim().isNotEmpty &&
                            _passwordController.text.trim().isNotEmpty &&
                            _confirmPasswordController.text.trim().isNotEmpty)
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              // Xử lý logic đăng ký tài khoản thành công
                            }
                          }
                        : null,
                    child: const MlKitText(
                      'ĐĂNG KÝ',
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
