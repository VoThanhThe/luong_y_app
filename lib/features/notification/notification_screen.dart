import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/f_core_image.dart';
import '../../shared/widgets/mlkit_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Thông báo',
      backgroundColor: AppColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FCoreImage(AppImages.imgNoData, width: 200, height: 200),
          const SizedBox(height: 8),
          Center(
            child: MlKitText(
              'Chưa có thông báo nào',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grayColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
