import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/mlkit_text.dart';

class CustomListTile extends StatelessWidget {
  final IconData leadingIcon;
  final Color iconColor;
  final String title;
  final Widget? titleWidget;
  final String?
  trailingText; // Có thể null nếu không muốn hiển thị chữ ở trailing
  final Widget? trailingWidget;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.leadingIcon,
    required this.iconColor,
    required this.title,
    this.titleWidget,
    this.trailingText,
    this.trailingWidget,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: iconColor.withAlpha(
              (0.1 * 255).toInt(),
            ), // Màu nền với độ trong suốt 10%
          ),
          child: Icon(leadingIcon, color: iconColor),
        ),
        title:
            titleWidget ??
            MlKitText(
              title,
              style: TextStyle(fontSize: 14, color: AppColors.blackColor),
            ),
        trailing:
            trailingWidget ??
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Chỉ hiển thị Text ở trailing nếu có truyền vào (như mục ngôn ngữ)
                if (trailingText != null) ...[
                  MlKitText(
                    trailingText!,
                    style: TextStyle(fontSize: 14, color: AppColors.blackColor),
                  ),
                  const SizedBox(width: 4),
                ],
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.grayColor,
                ),
              ],
            ),
        onTap: onTap,
      ),
    );
  }
}
