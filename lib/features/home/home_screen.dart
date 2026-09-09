import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart' show AppColors;
import '../../core/constants/app_gradients.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2; // Chọn mặc định tab "Trang chủ" ở giữa

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              // 1. Header: Avatar + Lời chào
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, color: Colors.white, size: 28),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Chào buổi sáng',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Grid 8 Feature Buttons (Nút tính năng)
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
                    _buildFeatureItem(Icons.calendar_month, 'Đặt hẹn khám'),
                    _buildFeatureItem(Icons.event_note, 'Lịch hẹn'),
                    _buildFeatureItem(Icons.assignment, 'Kết quả khám\nbệnh'),
                    _buildFeatureItem(Icons.person_pin, 'Hồ sơ'),
                    _buildFeatureItem(
                      Icons.health_and_safety,
                      'Kết quả khám\nsức khỏe',
                    ),
                    _buildFeatureItem(
                      Icons.request_quote,
                      'Tra cứu giá\ndịch vụ',
                    ),
                    _buildFeatureItem(Icons.info, 'Hướng dẫn\nđặt khám'),
                    _buildFeatureItem(Icons.alternate_email, 'Liên hệ'),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 3. Phần thân trắng bo góc (Banner + Mạng lưới + News)
              // Đã bỏ Expanded ở đây để ăn theo chiều cao thực tế của nội dung
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F9FC),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Promotion Banner
                    _buildPromotionBanner(),

                    const SizedBox(height: 24),

                    // Section Mạng lưới
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mạng lưới',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E5B6E),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Xem thêm',
                            style: TextStyle(
                              color: Color(0xFF1E5B6E),
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
                      itemBuilder: (context, index) => _buildHospitalCard(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tin tức & Truyền thông',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E5B6E),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Xem thêm',
                            style: TextStyle(
                              color: Color(0xFF1E5B6E),
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
                      itemBuilder: (context, index) => _buildNewsCard(),
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.grey[300]),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kết nối với chúng tôi',
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
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: [
                        _buildSocialMediaItem(Icons.facebook, 'Facebook'),
                        _buildSocialMediaItem(Icons.messenger, 'Messenger'),
                        _buildSocialMediaItem(Icons.messenger, 'Zalo'),
                        _buildSocialMediaItem(Icons.tiktok, 'Tiktok'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget hiển thị từng nút dịch vụ tròn
  Widget _buildFeatureItem(IconData icon, String title) {
    return Column(
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
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
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
    );
  }

  // Widget hiển thị từng nút dịch vụ social media
  Widget _buildSocialMediaItem(IconData icon, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 48),
        const SizedBox(height: 6),
        Text(
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
    );
  }

  // Card Banner Quảng cáo
  Widget _buildPromotionBanner() {
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
                const Text(
                  'Đặt lịch kiểm tra\nsức khỏe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
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
                  child: const Text(
                    'ĐẶT HẸN KHÁM',
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
              child: Image.network(
                'https://img.freepik.com/free-photo/female-doctor-hospital-with-stethoscope_23-2148827768.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
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

  // Card Thông tin Bệnh viện
  Widget _buildHospitalCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
              child: const Icon(
                Icons.local_hospital,
                size: 40,
                color: Colors.teal,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bệnh viện Hoàn Mỹ Sài Gòn',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00695C),
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '60-60A Phan Xích Long, Phường Cầu Kiệu, Hồ Chí Minh.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      '028 3990 2468',
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

  // Card Tin tức & Truyền thông
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
                child: const Icon(
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
                Text(
                  'Cộng đồng',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.grayColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bụng to bất thường do nhiều khối u lớn trong ổ bụng',
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
                      Icons.lock_clock,
                      size: 16,
                      color: AppColors.primaryLightColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
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