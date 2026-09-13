import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/utils/app_utils.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/f_core_image.dart'; // Sử dụng AppScaffold chuẩn của bạn
import '../../shared/widgets/mlkit_text.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Thông tin ứng dụng',
      isShowBackButton: true,
      backgroundColor: AppColors.grayLightColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mục 1: Hỗ trợ trực tuyến
            _buildSectionHeader('Hỗ trợ trực tuyến'),
            _buildCardGroup([
              _buildInfoTile(
                Icons.phone_outlined,
                '028 1234 4567',
                () => AppUtils.makePhoneCall('02812344567'),
              ),
              _buildDivider(),
              _buildInfoTile(
                Icons.mail_outline,
                'contactus.luongy@gmail.com',
                () => AppUtils.sendEmail('contactus.luongy@gmail.com'),
              ),
            ]),
            const SizedBox(height: 16),

            // Mục 2: Thông tin bảo mật
            _buildSectionHeader('Thông tin bảo mật'),
            _buildCardGroup([
              _buildNavigationTile('Chính sách quyền riêng tư', () {}),
              _buildDivider(),
              _buildNavigationTile('Điều khoản sử dụng', () {}),
            ]),
            const SizedBox(height: 16),

            // Mục 3: Thông tin ứng dụng (Version)
            _buildSectionHeader('Thông tin ứng dụng'),
            _buildCardGroup([
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MlKitText(
                      'Version: 1.0',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(height: 6),
                    MlKitText(
                      'Build: 1',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grayColor,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 30),

            // Footer thương hiệu Danh Y
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MlKitText(
                          'Ứng dụng ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        MlKitText(
                          'Lương Y',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    MlKitText(
                      'Ứng dụng chăm sóc sức khỏe\ndành cho gia đình bạn',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grayColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Ảnh minh họa vector (Bạn thay bằng Image.asset nếu có)
                    Expanded(
                      child: FCoreImage(
                        AppImages.imgMedicine,
                        fit: BoxFit
                            .fitHeight, // Giúp ảnh lấp đầy khung mà không bị méo hình
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: MlKitText(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  Widget _buildCardGroup(List<Widget> children) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.03 * 255).toInt()),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String text, VoidCallback onTap) {
    return Material(
      color:
          Colors.white, // Đặt màu nền trực tiếp tại Material thay vì trong suốt
      child: InkWell(
        // Hoặc dùng trực tiếp onTap trong ListTile nhưng cấu trúc lại Material
        onTap: onTap,
        child: ListTile(
          // Không để onTap ở đây nữa để tránh xung đột hiệu ứng splash của Material/InkWell
          leading: Icon(icon, color: AppColors.primaryColor),
          title: MlKitText(
            text,
            style: TextStyle(fontSize: 14, color: AppColors.blackColor),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationTile(String title, VoidCallback onTap) {
    return Material(
      color: Colors
          .white, // Đổi từ transparent sang white để hết warning và hiển thị ink splash đẹp hơn
      child: ListTile(
        title: MlKitText(
          title,
          style: TextStyle(fontSize: 14, color: AppColors.blackColor),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.grayColor,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 0.5, indent: 16, endIndent: 16);
  }
}
