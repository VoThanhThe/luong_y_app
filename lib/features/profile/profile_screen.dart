import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../shared/widgets/app_text.dart';
import 'providers/profile_provider.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';
import 'widgets/profile_custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: Consumer<ProfileProvider>(
          builder: (context, viewModel, child) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                viewModel.handleScroll(scrollInfo);
                return false;
              },
              child: Stack(
                children: [
                  // Nội dung cuộn
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const ProfileHeader(),

                        // Menu Thông tin
                        Container(
                          color: AppColors.whiteColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: AppText(
                                  'Thông tin',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ProfileMenuItem(
                                icon: Icons.account_circle_outlined,
                                title: 'Thông tin tài khoản',
                                onTap: viewModel.onAccountInfoTap,
                              ),
                              ProfileMenuItem(
                                icon: Icons.monitor_heart_outlined,
                                title: 'Chỉ số sức khoẻ',
                                onTap: viewModel.onHealthMetricsTap,
                              ),
                              ProfileMenuItem(
                                icon: Icons.assignment_outlined,
                                title: 'Hồ sơ khám chữa bệnh',
                                onTap: viewModel.onMedicalRecordsTap,
                              ),
                              ProfileMenuItem(
                                icon: Icons.description_outlined,
                                title: 'Khám sức khoẻ định kỳ',
                                onTap: viewModel.onPeriodicHealthCheckTap,
                              ),
                              ProfileMenuItem(
                                icon: Icons.medical_services_outlined,
                                title: 'Kết quả XN & CLS',
                                onTap: viewModel.onLabResultsTap,
                              ),
                              ProfileMenuItem(
                                icon: Icons.topic_outlined,
                                title: 'Hồ sở giấy tờ ra viện',
                                onTap: viewModel.onDischargePapersTap,
                              ),
                              ProfileMenuItem(
                                icon: Icons.calendar_today_outlined,
                                title: 'Quản lý chia sẻ hồ sơ',
                                onTap: viewModel.onShareManagementTap,
                              ),
                              ProfileMenuItem(
                                icon: Icons.upload_file_outlined,
                                title: 'Tài liệu tải lên',
                                onTap: viewModel.onUploadedFilesTap,
                              ),
                              ProfileMenuItem(
                                icon: Icons.pending_actions_outlined,
                                title: 'Hàng đợi khám bệnh',
                                onTap: viewModel.onQueueTap,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Lịch sử đã đặt gần đây
                        Container(
                          width: double.infinity,
                          color: AppColors.whiteColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: AppText(
                                  'Lịch sử đã đặt gần đây',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Center(
                                child: AppText(
                                  'Chưa có lịch sử đặt hẹn',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.grayDarkColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Hồ sơ người thân
                        Container(
                          width: double.infinity,
                          color: AppColors.whiteColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: AppText(
                                  'Hồ sơ người thân',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Center(
                                child: CupertinoButton(
                                  onPressed: viewModel.onAddRelativeProfile,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryDarkColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Thêm hồ sơ'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),

                  // Custom AppBar phía trên
                  ProfileCustomAppBar(show: viewModel.showCustomAppBar),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
