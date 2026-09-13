import 'package:google_mlkit_translation/google_mlkit_translation.dart';

/// Dịch văn bản Anh ↔ Việt ngay trên thiết bị bằng Google ML Kit.
class OnDeviceTranslationService {
  const OnDeviceTranslationService._();

  static final _modelManager = OnDeviceTranslatorModelManager();
  static final Map<String, Future<String>> _translations = {};
  static Future<void>? _modelPreparation;

  static Future<void> prepareVietnameseEnglishModels() async {
    final pendingPreparation = _modelPreparation;
    if (pendingPreparation != null) return pendingPreparation;

    final preparation = _downloadVietnameseEnglishModels();
    _modelPreparation = preparation;

    try {
      await preparation;
    } catch (_) {
      if (identical(_modelPreparation, preparation)) {
        _modelPreparation = null;
      }
      rethrow;
    }
  }

  static Future<void> _downloadVietnameseEnglishModels() async {
    // The iOS ML Kit model manager supports one active download at a time.
    // Starting both downloads with Future.wait can cancel one of them.
    await _modelManager.downloadModel(
      TranslateLanguage.vietnamese.bcpCode,
      isWifiRequired: false,
    );
    await _modelManager.downloadModel(
      TranslateLanguage.english.bcpCode,
      isWifiRequired: false,
    );
  }

  static Future<String> translateVietnameseToEnglish(String text) {
    if (text.trim().isEmpty) return Future.value(text);

    return _translations.putIfAbsent(text, () async {
      await prepareVietnameseEnglishModels();
      return translateEnglishVietnamese(text: text, fromEnglish: false);
    });
  }

  static Future<String> translateEnglishVietnamese({
    required String text,
    required bool fromEnglish,
  }) async {
    final translator = OnDeviceTranslator(
      sourceLanguage: fromEnglish
          ? TranslateLanguage.english
          : TranslateLanguage.vietnamese,
      targetLanguage: fromEnglish
          ? TranslateLanguage.vietnamese
          : TranslateLanguage.english,
    );

    try {
      return await translator.translateText(text);
    } finally {
      await translator.close();
    }
  }
}
