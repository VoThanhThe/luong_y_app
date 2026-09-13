import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'translations/en_us.dart';
import 'translations/vi_vn.dart';
import 'translations/zh_cn.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocaleVi = Locale('vi', 'VN');
  static const fallbackLocaleEn = Locale('en', 'US');
  static const fallbackLocaleZh = Locale('zh', 'CN');
  @override
  Map<String, Map<String, String>> get keys => {
    'vi_VN': viVn,
    'en_US': enUs,
    'zh_CN': zhCn,
  };
}
