import 'package:flutter/foundation.dart';

import 'language_helper.dart';

/// Global language state used by the on-device ML Kit translation widgets.
class AppLanguage {
  AppLanguage._();

  static final ValueNotifier<String> code = ValueNotifier<String>('vi');

  static Future<void> initialize() async {
    code.value = await LanguageHelper.getSavedLanguageCode();
  }

  static Future<void> change(String languageCode) async {
    await LanguageHelper.saveLanguageCode(languageCode);
    code.value = languageCode;
  }
}
