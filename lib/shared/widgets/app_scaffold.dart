import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_gradients.dart';

class AppScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final bool isShowBackButton;
  final Widget? action;
  const AppScaffold({super.key, required this.title, required this.body, this.isShowBackButton = false, this.action});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 110,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppGradients.appBarGradient,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.isShowBackButton
                        ? IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 36),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        : const SizedBox(width: 50, height: 50,), // Placeholder để giữ khoảng cách khi không có nút back
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.action ?? const SizedBox(width: 50, height: 50,), // Placeholder để giữ khoảng cách khi không có action
                  ],
                ),
              ],
            )
          ),
          widget.body,
        ],
      ),
    );
  }
}