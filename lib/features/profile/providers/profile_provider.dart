import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  bool _showCustomAppBar = false;
  final double scrollThreshold = 80.0;

  bool get showCustomAppBar => _showCustomAppBar;

  // Xử lý logic ẩn/hiện custom appbar khi scroll
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

  // Các sự kiện click menu
  void onAccountInfoTap() {
    // Xử lý logic điều hướng hoặc gọi API thông tin tài khoản
  }

  void onHealthMetricsTap() {}
  void onMedicalRecordsTap() {}
  void onPeriodicHealthCheckTap() {}
  void onLabResultsTap() {}
  void onDischargePapersTap() {}
  void onShareManagementTap() {}
  void onUploadedFilesTap() {}
  void onQueueTap() {}
  void onAddRelativeProfile() {}
}