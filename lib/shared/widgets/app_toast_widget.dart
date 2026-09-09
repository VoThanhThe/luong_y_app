import 'package:flutter/material.dart';

import '../../core/utils/toast_enums.dart';

class AppToastWidget extends StatefulWidget {
  final ToastStatus status;
  final String title;
  final String? subtitle;
  final Duration duration;
  final VoidCallback onDismissed;

  const AppToastWidget({
    super.key,
    required this.status,
    required this.title,
    this.subtitle,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<AppToastWidget> createState() => _AppToastWidgetState();
}

class _AppToastWidgetState extends State<AppToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.15, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.15, curve: Curves.easeOut),
      ),
    );

    // Chạy animation và tự ẩn khi hết thời gian
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onDismissed();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        // 🔥 Đặt Dismissible ở lớp ngoài cùng của Widget
        child: Dismissible(
          key: UniqueKey(),
          // Cho phép vuốt hất lên trên HOẶC vuốt sang 2 bên để tắt
          direction: DismissDirection.up, 
          // Cho phép nhận diện thao tác vuốt tốt hơn trên toàn bộ khung Toast
          behavior: HitTestBehavior.opaque,
          onDismissed: (direction) {
            _controller.stop(); // Dừng bộ đếm thời gian ngay lập tức
            widget.onDismissed(); // Gọi hàm tháo Toast khỏi màn hình
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: widget.status.gradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.2 * 255).toInt()),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            widget.status.icon,
                            color: Colors.white,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                if (widget.subtitle != null &&
                                    widget.subtitle!.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.subtitle!,
                                    style: TextStyle(
                                      color: Colors.white.withAlpha((0.9 * 255).toInt()),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: 1.0 - _controller.value,
                          backgroundColor: Colors.white.withAlpha((0.2 * 255).toInt()),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          minHeight: 3,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}