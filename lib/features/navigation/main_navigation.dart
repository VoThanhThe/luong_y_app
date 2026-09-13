import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_gradients.dart';
import '../../core/constants/app_icons.dart';
import '../../core/lang/app_language.dart';
import '../../core/lang/on_device_translation_service.dart';
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
  final Map<String, String> _translatedLabels = {};
  static const _labels = [
    'Hồ sơ',
    'Thông báo',
    'Trang chủ',
    'Lịch hẹn',
    'Tiện ích',
  ];

  // 2. Danh sách các màn hình tương ứng với từng tab trên thanh navigation
  final List<Widget> _screens = [
    const ProfileScreen(), // Tab 0: Hồ sơ
    const NotificationScreen(), // Tab 1: Thông báo
    const HomeScreen(), // Tab 2: Trang chủ
    const AppointmentScreen(), // Tab 3: Lịch hẹn
    const UtilitiesScreen(), // Tab 4: Tiện ích
  ];

  @override
  void initState() {
    super.initState();
    AppLanguage.code.addListener(_updateLabels);
    _updateLabels();
  }

  @override
  void dispose() {
    AppLanguage.code.removeListener(_updateLabels);
    super.dispose();
  }

  void _updateLabels() {
    if (AppLanguage.code.value != 'en') {
      setState(_translatedLabels.clear);
      return;
    }

    _translatedLabels.clear();
    for (final label in _labels) {
      OnDeviceTranslationService.translateVietnameseToEnglish(label)
          .then((value) {
            if (mounted && AppLanguage.code.value == 'en') {
              setState(() => _translatedLabels[label] = value);
            }
          })
          .catchError((_) {});
    }
    setState(() {});
  }

  String _label(String vietnamese) =>
      _translatedLabels[vietnamese] ?? vietnamese;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack giúp giữ nguyên trạng thái (State) của các màn hình khi chuyển tab
      body: IndexedStack(index: _selectedIndex, children: _screens),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_shared),
            label: _label('Hồ sơ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: _label('Thông báo'),
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
              child: FCoreImage(AppIcons.icLogo, width: 28, height: 28),
            ),
            label: _label('Trang chủ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: _label('Lịch hẹn'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: _label('Tiện ích'),
          ),
        ],
      ),
    );
  }
}
