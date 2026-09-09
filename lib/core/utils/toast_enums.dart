import 'package:flutter/material.dart';

enum ToastStatus { success, error, warning, protect }

extension ToastStatusExtension on ToastStatus {
  // Nền Gradient cho từng loại Toast
  LinearGradient get gradient {
    switch (this) {
      case ToastStatus.success:
        return const LinearGradient(
          colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ToastStatus.error:
        return const LinearGradient(
          colors: [Color(0xFFCB2D3E), Color(0xFFEF473A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ToastStatus.warning:
        return const LinearGradient(
          colors: [Color(0xFFFF8008), Color(0xFFFFC837)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ToastStatus.protect:
        return const LinearGradient(
          colors: [Color(0xFF4776E6), Color(0xFF8E54E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  // Icon tương ứng cho từng trạng thái
  IconData get icon {
    switch (this) {
      case ToastStatus.success:
        return Icons.check_circle_rounded;
      case ToastStatus.error:
        return Icons.cancel_rounded;
      case ToastStatus.warning:
        return Icons.warning_amber_rounded;
      case ToastStatus.protect:
        return Icons.shield_rounded;
    }
  }
}