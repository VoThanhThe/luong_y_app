import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/widgets/app_toast_widget.dart';
import 'toast_enums.dart';

class ToastUtils {
  static OverlayEntry? _overlayEntry;

  static void show({
    BuildContext? context,
    required ToastStatus status,
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    dismiss();

    final targetContext = context ?? Get.overlayContext;
    if (targetContext == null) return;

    final overlayState = Overlay.maybeOf(targetContext);
    if (overlayState == null) return;

    _overlayEntry = OverlayEntry(
      builder: (ctx) => Positioned(
        top: MediaQuery.of(ctx).padding.top + 10,
        left: 0,
        right: 0,
        // 🔥 Thêm SafeArea hoặc bọc GestureDetector để chắc chắn nhận được chạm/vuốt
        child: AppToastWidget(
          status: status,
          title: title,
          subtitle: subtitle,
          duration: duration,
          onDismissed: dismiss,
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  static void dismiss() {
    if (_overlayEntry != null) {
      try {
        _overlayEntry?.remove();
      } catch (_) {
      } finally {
        _overlayEntry = null;
      }
    }
  }
}