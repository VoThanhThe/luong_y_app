
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_gradients.dart';
import '../../core/constants/app_icons.dart';
import '../../shared/widgets/f_core_image.dart';
import '../appointment/appointment_screen.dart';
import '../home/home_screen.dart';
import '../notification/notification_screen.dart';
import '../profile/profile_screen.dart';
import '../utility/utilities_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // 1. Khai báo chỉ số tab đang chọn (Mặc định là 2: Trang chủ)
  int _selectedIndex = 2;

  // 2. Danh sách các màn hình tương ứng với từng tab trên thanh navigation
  final List<Widget> _screens = [
    const ProfileScreen(),      // Tab 0: Hồ sơ
    const NotificationScreen(), // Tab 1: Thông báo
    const HomeScreen(),         // Tab 2: Trang chủ
    const AppointmentScreen(),  // Tab 3: Lịch hẹn
    const UtilitiesScreen(),    // Tab 4: Tiện ích
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack giúp giữ nguyên trạng thái (State) của các màn hình khi chuyển tab
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: AppColors.whiteColor,

        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.grayColor,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.folder_shared),
            label: 'Hồ sơ',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppGradients.primaryGradient,
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                shape: BoxShape.circle,
              ),
              child: FCoreImage(AppIcons.ic_logo, width: 28, height: 28),
            ),
            label: 'Trang chủ',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Lịch hẹn',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: 'Tiện ích',
          ),
        ],
      ),
    );
  }
}
