import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/lang/app_language.dart';
import '../../core/lang/on_device_translation_service.dart';
import '../../core/utils/toast_enums.dart';
import '../../core/utils/toast_utils.dart';
import '../../shared/widgets/app_popup.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/app_modal.dart';
import '../../shared/widgets/mlkit_text.dart';
import 'app_info_screen.dart';
import 'f_a_q_screen.dart';
import 'widgets/custom_list_tile.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({super.key});

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  String _languageCode = 'vi';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    if (mounted) {
      setState(() => _languageCode = AppLanguage.code.value);
    }
  }

  Future<void> _changeLanguage(String languageCode) async {
    if (languageCode == 'en') {
      await OnDeviceTranslationService.prepareVietnameseEnglishModels();
    }
    await AppLanguage.change(languageCode);
    if (mounted) {
      setState(() => _languageCode = languageCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Tiện ích',
      titleWidget: MlKitText(
        'Tiện ích',
        languageCode: _languageCode,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://i.pinimg.com/736x/a4/81/63/a481639243e8b1cc2579be1e480f2dec.jpg',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Võ Thành Thế'.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              Text(
                                '0384234234'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                MlKitText(
                  'Tiện ích',
                  languageCode: _languageCode,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            color: AppColors.whiteColor,
            child: Column(
              children: [
                CustomListTile(
                  leadingIcon: Icons.language,
                  iconColor: AppColors.blueColor,
                  title: 'Ngôn ngữ',
                  titleWidget: _menuText('Ngôn ngữ'),
                  trailingWidget: _menuText(
                    _languageCode == 'en' ? 'Tiếng Anh' : 'Tiếng Việt',
                  ),
                  onTap: () {
                    String selectedLanguage = _languageCode;

                    AppModal.showSelectionModal(
                      context: context,
                      title: 'Chọn ngôn ngữ',
                      titleWidget: MlKitText(
                        'Chọn ngôn ngữ',
                        languageCode: _languageCode,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      confirmText: 'XÁC NHẬN',
                      confirmWidget: MlKitText(
                        'XÁC NHẬN',
                        languageCode: _languageCode,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      children: [
                        StatefulBuilder(
                          builder: (context, setModalState) {
                            return Column(
                              children: [
                                _buildLanguageOptionItem(
                                  title: 'Tiếng Việt',
                                  isSelected: selectedLanguage == 'vi',
                                  onTap: () {
                                    setModalState(() {
                                      selectedLanguage = 'vi';
                                    });
                                  },
                                ),
                                const SizedBox(height: 12),
                                _buildLanguageOptionItem(
                                  title: 'Tiếng Anh',
                                  isSelected: selectedLanguage == 'en',
                                  onTap: () {
                                    setModalState(() {
                                      selectedLanguage = 'en';
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                      onConfirm: () async {
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                        try {
                          await _changeLanguage(selectedLanguage);
                        } catch (_) {
                          if (context.mounted) {
                            ToastUtils.show(
                              context: context,
                              status: ToastStatus.error,
                              title: 'Không thể tải ngôn ngữ tiếng Anh',
                              subtitle: 'Hãy kiểm tra kết nối mạng và thử lại.',
                            );
                          }
                        }
                      },
                    );
                  },
                ),
                CustomListTile(
                  leadingIcon: Icons.verified_user,
                  iconColor: AppColors.primaryColor,
                  title: 'Đăng nhập và bảo mật',
                  titleWidget: _menuText('Đăng nhập và bảo mật'),
                  onTap: () {
                    // Xử lý đổi ngôn ngữ
                  },
                ),
                CustomListTile(
                  leadingIcon: Icons.help,
                  iconColor: AppColors.orangeColor,
                  title: 'Các vấn đề thường gặp',
                  titleWidget: _menuText('Các vấn đề thường gặp'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FAQScreen(),
                      ),
                    );
                  },
                ),
                CustomListTile(
                  leadingIcon: Icons.sentiment_satisfied_alt,
                  iconColor: AppColors.greenColor,
                  title: 'Góp ý dịch vụ',
                  titleWidget: _menuText('Góp ý dịch vụ'),
                  onTap: () {
                    AppModal.showNormallyModal(
                      context: context,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chia sẽ với mình trải nghiệm của bạn nhé',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor,
                              ),
                            ),
                            Text(
                              'Giúp mình chọn bệnh viện để lắng nghe ý kiến từ bạn',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    AppPopup.showRatingDialog(
                                      context: context,
                                      title:
                                          'Bạn có hài lòng về dịch vụ của Bệnh viện Hoàn Mỹ Sài Gòn?',
                                      child: Text(
                                        'Đánh giá của bạn giúp chúng tôi cải thiện dịch vụ tốt hơn',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      textNegativePressed: 'Không hài lòng',
                                      textPositivePressed: 'Hài lòng',
                                      onNegativePressed: () {
                                        Navigator.pop(context);
                                        AppPopup.showRatingDialog(
                                          context: context,
                                          title:
                                              'Bạn không hài lòng điều gì ở Bệnh viện Hoàn Mỹ Sài Gòn?',
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.grayLightColor
                                                  .withAlpha(
                                                    (0.5 * 255).toInt(),
                                                  ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextField(
                                              controller:
                                                  TextEditingController(),
                                              maxLines: 5,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Bạn có thể chia sẽ thêm?',
                                                hintStyle: TextStyle(
                                                  color: AppColors.grayColor,
                                                  fontSize: 14,
                                                ),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 16,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          textNegativePressed: 'Bỏ qua',
                                          textPositivePressed: 'Gửi',
                                          onNegativePressed: () {
                                            Navigator.pop(context);
                                          },
                                          onPositivePressed: () {
                                            Navigator.pop(context);
                                            ToastUtils.show(
                                              status: ToastStatus.success,
                                              title: 'Góp ý thành công',
                                            );
                                          },
                                        );
                                      },
                                      onPositivePressed: () {
                                        Navigator.pop(context);
                                        AppPopup.showRatingDialog(
                                          context: context,
                                          title:
                                              'Bạn hài lòng điều gì ở Bệnh viện Hoàn Mỹ Sài Gòn?',
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.grayLightColor
                                                  .withAlpha(
                                                    (0.5 * 255).toInt(),
                                                  ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextField(
                                              controller:
                                                  TextEditingController(),
                                              maxLines: 5,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Bạn có thể chia sẽ thêm?',
                                                hintStyle: TextStyle(
                                                  color: AppColors.grayColor,
                                                  fontSize: 14,
                                                ),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 16,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          textNegativePressed: 'Bỏ qua',
                                          textPositivePressed: 'Gửi',
                                          onNegativePressed: () {
                                            Navigator.pop(context);
                                          },
                                          onPositivePressed: () {
                                            Navigator.pop(context);
                                            ToastUtils.show(
                                              status: ToastStatus.success,
                                              title: 'Góp ý thành công',
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.grayLightColor.withAlpha(
                                        (0.5 * 255).toInt(),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Bệnh viện Hoàn Mỹ Sài Gòn',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemCount: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                CustomListTile(
                  leadingIcon: Icons.info,
                  iconColor: AppColors.primaryColor,
                  title: 'Thông tin ứng dụng',
                  titleWidget: _menuText('Thông tin ứng dụng'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppInfoScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            color: AppColors.whiteColor,
            child: CustomListTile(
              leadingIcon: Icons.exit_to_app,
              iconColor: AppColors.redColor,
              title: 'Đăng xuất',
              titleWidget: _menuText('Đăng xuất'),
              onTap: () {
                // Xử lý đổi ngôn ngữ
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuText(String text) {
    return MlKitText(
      text,
      languageCode: _languageCode,
      style: TextStyle(fontSize: 14, color: AppColors.blackColor),
    );
  }

  Widget _buildLanguageOptionItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MlKitText(
              title,
              languageCode: _languageCode,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primaryColor : Colors.black87,
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primaryColor, size: 20),
          ],
        ),
      ),
    );
  }
}
