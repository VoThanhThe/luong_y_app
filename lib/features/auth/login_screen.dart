import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luong_y_app/shared/widgets/custom_text_field.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/f_core_image.dart';
import '../../shared/widgets/mlkit_text.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onFocusAll() {
    _phoneFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onFocusAll(),
      child: AppScaffold(
        title: 'Đăng nhập',
        isShowBackButton: true,
        backgroundColor: AppColors.grayLightColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FCoreImage(AppImages.imgMedicine, height: 200,),
                const SizedBox(height: 10),
                MlKitText(
                  'Chào mừng bạn quay trở lại!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grayDarkColor,
                  ),
                ),
                const SizedBox(height: 6),
                MlKitText(
                  'Đăng nhập để quản lý lịch khám và sức khỏe của bạn',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
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
                  onChanged: (t) {
                    setState(() => {});
                  },
                ),
                const SizedBox(height: 16),

                // Ô nhập Mật khẩu
                CustomTextField(
                  label: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu của bạn',
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: _obscurePassword,
                  isPassword: true,
                  onTogglePassword: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    return null;
                  },
                  onChanged: (t) {
                    setState(() => {});
                  },
                ),
                const SizedBox(height: 30),

                // Nút Đăng nhập
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (_phoneController.text.trim().isNotEmpty &&
                              _passwordController.text.trim().isNotEmpty)
                          ? AppColors.primaryColor
                          : AppColors.grayColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed:
                        (_phoneController.text.trim().isNotEmpty &&
                            _passwordController.text.trim().isNotEmpty)
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              // Xử lý logic đăng nhập
                            }
                          }
                        : null,
                    child: const MlKitText(
                      'ĐĂNG NHẬP',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                  child: MlKitText(
                    'Quên mật khẩu',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: MlKitText(
                    'Đăng ký',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
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
