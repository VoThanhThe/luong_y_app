import 'package:flutter/material.dart';

import '../../shared/widgets/mlkit_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showCustomAppBar = false;
  final double _scrollThreshold = 80.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.axis == Axis.vertical) {
            if (scrollInfo.metrics.pixels > _scrollThreshold &&
                !_showCustomAppBar) {
              setState(() {
                _showCustomAppBar = true;
              });
            } else if (scrollInfo.metrics.pixels <= _scrollThreshold &&
                _showCustomAppBar) {
              setState(() {
                _showCustomAppBar = false;
              });
            }
          }
          return false;
        },
        child: Stack(
          children: [
            // Nội dung chính của Profile cuộn ở dưới
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
              child: Column(
                children: [
                  const SizedBox(height: 40), // Khoảng trống cho phần đầu
                  // Header Profile (Avatar + Họ tên)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.05 * 255).toInt()),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MlKitText(
                              'Võ Thành Thế',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            MlKitText(
                              'Bệnh nhân • 0912 345 678',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Danh sách các mục quản lý hồ sơ
                  _buildSectionTitle('Quản lý y tế'),
                  _buildProfileMenuItem(
                    Icons.medical_services_outlined,
                    'Hồ sơ khám chữa bệnh',
                    () {},
                  ),
                  _buildProfileMenuItem(
                    Icons.monitor_heart_outlined,
                    'Chỉ số sức khỏe',
                    () {},
                  ),
                  _buildProfileMenuItem(
                    Icons.description_outlined,
                    'Kết quả XN & CLS',
                    () {},
                  ),
                  _buildProfileMenuItem(
                    Icons.calendar_today_outlined,
                    'Lịch hẹn đã đặt gần đây',
                    () {},
                  ),

                  const SizedBox(height: 16),
                  _buildSectionTitle('Cài đặt & Tài khoản'),
                  _buildProfileMenuItem(
                    Icons.person_outline,
                    'Thông tin tài khoản',
                    () {},
                  ),
                  _buildProfileMenuItem(
                    Icons.security_outlined,
                    'Đăng nhập và bảo mật',
                    () {},
                  ),
                  _buildProfileMenuItem(
                    Icons.share_outlined,
                    'Quản lý chia sẻ hồ sơ',
                    () {},
                  ),
                  _buildProfileMenuItem(
                    Icons.logout,
                    'Đăng xuất',
                    () {},
                    isRed: true,
                  ),

                  const SizedBox(height: 200), // Khoảng trống cuối cùng
                ],
              ),
            ),

            // Custom AppBar trượt từ trên xuống khi scroll > 50px
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: _showCustomAppBar ? 0 : -130,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 110,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.15 * 255).toInt()),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 48), // Cân bằng không gian
                        MlKitText(
                          'Hồ sơ cá nhân',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Xử lý nút setting ở appbar
                          },
                        ),
                      ],
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

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: MlKitText(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00796B),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isRed = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isRed ? Colors.red : const Color(0xFF00796B)),
      title: MlKitText(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isRed ? Colors.red : Colors.black87,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
