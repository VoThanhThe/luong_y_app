import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_gradients.dart';
import '../../core/constants/app_images.dart';
import '../../core/lang/language_helper.dart';
import '../../shared/widgets/mlkit_text.dart';
import '../navigation/main_navigation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isLoading = false; // Biến trạng thái hiển thị loading

  // Hàm lưu trạng thái đã xem Onboarding
  void _completeOnboarding() async {
    setState(() {
      _isLoading = true; // Bật trạng thái loading khi bấm
    });

    await LanguageHelper.saveOnboardingCompleted();

    // Đợi frame hiện tại render xong hiệu ứng loading rồi mới chuyển trang
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 50), () {
        Get.offAll(() => const MainNavigation());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppGradients.primaryGradient,
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(AppImages.doctor, fit: BoxFit.fitHeight),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      MlKitText(
                        'Chăm sóc sức khoẻ\ntrong tầm tay.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                          height: 1.3, // Khoảng cách dòng thoáng hơn
                        ),
                      ),
                      const SizedBox(height: 12),
                      MlKitText(
                        'Kết nối chăm sóc sức khoẻ mọi lúc, mọi nơi.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grayLightColor,
                          letterSpacing: 0.3,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width:
                            200, // Hoặc double.infinity nếu bạn muốn nút tràn viền ngang
                        height: 48, // Cố định chiều cao chuẩn cho nút
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _completeOnboarding,
                          child: _isLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              : MlKitText(
                                  'Bắt đầu',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
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
