import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool _showCustomAppBar = false;
  final double scrollThreshold = 80.0;

  bool get showCustomAppBar => _showCustomAppBar;

  // Lắng nghe sự kiện scroll để ẩn/hiện Custom AppBar
  void handleScroll(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      if (scrollInfo.metrics.pixels > scrollThreshold && !_showCustomAppBar) {
        _showCustomAppBar = true;
        notifyListeners();
      } else if (scrollInfo.metrics.pixels <= scrollThreshold && _showCustomAppBar) {
        _showCustomAppBar = false;
        notifyListeners();
      }
    }
  }

  // Các sự kiện click tính năng, banner, mạng lưới...
  void onFeatureItemTap(String title) {
    // Xử lý sự kiện click tính năng
  }

  void onSocialMediaTap(String title) {
    // Xử lý mạng xã hội
  }

  void onBookAppointmentTap() {
    // Xử lý đặt khám
  }

  void onSeeMoreNetworkTap() {}
  void onSeeMoreNewsTap() {}
}