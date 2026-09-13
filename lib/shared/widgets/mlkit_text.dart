import 'package:flutter/material.dart';

import '../../core/lang/app_language.dart';
import '../../core/lang/on_device_translation_service.dart';

/// Displays Vietnamese text directly or its English ML Kit translation.
class MlKitText extends StatefulWidget {
  const MlKitText(
    this.text, {
    super.key,
    this.languageCode,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;

  /// When omitted, follows the application's shared language selection.
  final String? languageCode;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  State<MlKitText> createState() => _MlKitTextState();
}

class _MlKitTextState extends State<MlKitText> {
  Future<String>? _translation;

  @override
  void initState() {
    super.initState();
    _updateTranslation();
  }

  @override
  void didUpdateWidget(covariant MlKitText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.languageCode != widget.languageCode) {
      _updateTranslation();
    }
  }

  void _updateTranslation() {
    _translation = widget.languageCode == 'en'
        ? OnDeviceTranslationService.translateVietnameseToEnglish(widget.text)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.languageCode == null) {
      return ValueListenableBuilder<String>(
        valueListenable: AppLanguage.code,
        builder: (context, languageCode, child) => MlKitText(
          widget.text,
          languageCode: languageCode,
          style: widget.style,
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          overflow: widget.overflow,
        ),
      );
    }

    if (_translation == null) return _buildText(widget.text);

    return FutureBuilder<String>(
      future: _translation,
      builder: (context, snapshot) => _buildText(snapshot.data ?? widget.text),
    );
  }

  Widget _buildText(String value) {
    return Text(
      value,
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
