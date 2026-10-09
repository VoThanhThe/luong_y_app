import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luong_y_app/features/home/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart' show AppColors;
import '../../core/constants/app_gradients.dart';
import '../../core/constants/app_images.dart';
import '../../shared/widgets/app_text.dart';
import '../../shared/widgets/f_core_image.dart';
import 'widgets/home_custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<HomeProvider>(
          builder: (context, viewModel, child) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                viewModel.handleScroll(scrollInfo);
                return false;
              },
              child: Stack(
                children: [
                  // Nội dung chính có thể cuộn
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: AppGradients.primaryGradient,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          // 1. Header: Avatar + Lời chào
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.white24,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const AppText(
                                      'good_morning',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const AppText(
                                      'profile_name',
                                      uppercase: true,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // 2. Grid 8 Feature Buttons
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: GridView.count(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 0.78,
                              children: [
                                _buildFeatureItem(
                                  Icons.calendar_month,
                                  'Đặt hẹn khám',
                                  viewModel,
                                ),
                                _buildFeatureItem(
                                  Icons.event_note,
                                  'Lịch hẹn',
                                  viewModel,
                                ),
                                _buildFeatureItem(
                                  Icons.assignment,
                                  'Kết quả khám\nbệnh',
                                  viewModel,
                                ),
                                _buildFeatureItem(
                                  Icons.person_pin,
                                  'Hồ sơ',
                                  viewModel,
                                ),
                                _buildFeatureItem(
                                  Icons.health_and_safety,
                                  'Kết quả khám\nsức khỏe',
                                  viewModel,
                                ),
                                _buildFeatureItem(
                                  Icons.request_quote,
                                  'Tra cứu giá\ndịch vụ',
                                  viewModel,
                                ),
                                _buildFeatureItem(
                                  Icons.info,
                                  'Hướng dẫn\nđặt khám',
                                  viewModel,
                                ),
                                _buildFeatureItem(
                                  Icons.alternate_email,
                                  'Liên hệ',
                                  viewModel,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // 3. Phần thân trắng bo góc
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF7F9FC),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildPromotionBanner(viewModel),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      'network',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryDarkColor,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: viewModel.onSeeMoreNetworkTap,
                                      child: AppText(
                                        'see_more',
                                        style: TextStyle(
                                          color: AppColors.primaryDarkColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemCount: 3,
                                  itemBuilder: (context, index) =>
                                      _buildHospitalCard(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 12),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      'news_media',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryDarkColor,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: viewModel.onSeeMoreNewsTap,
                                      child: AppText(
                                        'see_more',
                                        style: TextStyle(
                                          color: AppColors.primaryDarkColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      _buildNewsCard(),
                                  separatorBuilder: (context, index) =>
                                      Divider(color: Colors.grey[300]),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                              ],
                            ),
                          ),

                          // Phần Mạng xã hội phía dưới cùng
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  'connect_with_us',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                GridView.count(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  children: [
                                    _buildSocialMediaItem(
                                      AppImages.logoFacebook,
                                      'Facebook',
                                      viewModel,
                                    ),
                                    _buildSocialMediaItem(
                                      AppImages.logoMessenger,
                                      'Messenger',
                                      viewModel,
                                    ),
                                    _buildSocialMediaItem(
                                      AppImages.logoZalo,
                                      'Zalo',
                                      viewModel,
                                    ),
                                    _buildSocialMediaItem(
                                      AppImages.logoTiktok,
                                      'Tiktok',
                                      viewModel,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),

                  // Custom AppBar trượt xuống phía trên cùng
                  HomeCustomAppBar(show: viewModel.showCustomAppBar),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    IconData icon,
    String title,
    HomeProvider viewModel,
  ) {
    return InkWell(
      onTap: () => viewModel.onFeatureItemTap(title),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                center: Alignment.center,
                radius: 0.85,
                colors: [
                  Color(0xFF6CCBD1),
                  Color.fromARGB(255, 5, 152, 162),
                  Color.fromARGB(255, 2, 114, 122),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.whiteColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 6),
          AppText(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              height: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaItem(
    String image,
    String title,
    HomeProvider viewModel,
  ) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => viewModel.onSocialMediaTap(title),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FCoreImage(image, width: 48, height: 48),
          const SizedBox(height: 6),
          AppText(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              height: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionBanner(HomeProvider viewModel) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF009688), Color(0xFF80CBC4)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppText(
                  'schedule_a_health_checkup',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: viewModel.onBookAppointmentTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF00796B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const AppText(
                    'book_an_appointment',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://img.freepik.com/free-photo/female-doctor-hospital-with-stethoscope_23-2148827768.jpg',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(
                  Icons.person_outline,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 90,
              height: 90,
              color: Colors.grey[200],
              child: CachedNetworkImage(
                imageUrl:
                    'https://i.pinimg.com/736x/9c/e0/e5/9ce0e5afe08d9f7ab06b6736f62796b6.jpg',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(
                  Icons.local_hospital,
                  size: 40,
                  color: Colors.teal,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  'hoan_my_saigon_hospital',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00695C),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Expanded(
                      child: AppText(
                        '60-60a,Phan Xich Long, Phuong Cau Kieu, Ho Chi Minh',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.phone, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    AppText(
                      '02839902468',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard() {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 90,
                height: 120,
                color: Colors.grey[200],
                child: CachedNetworkImage(
                  imageUrl:
                      'https://i.pinimg.com/1200x/5b/2f/38/5b2f38b36ea96da0f4475f5381defe79.jpg',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.local_hospital,
                    size: 40,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'community',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.grayColor,
                  ),
                ),
                const SizedBox(height: 4),
                AppText(
                  'app_text_011',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.primaryLightColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: AppText(
                        '21/10/2025',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}