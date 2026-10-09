import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../core/lang/translations/vi_VN.dart';
import '../../core/lang/app_text_keys.dart';

/// Displays a pretranslated string from the GetX locale dictionaries.
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.languageCode,
    this.size,
    this.parameters,
    this.uppercase = false,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;

  /// Kept for call-site compatibility; GetX resolves the active locale.
  final String? languageCode;
  final double? size;
  final Map<String, String>? parameters;
  final bool uppercase;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final key = _keyForText(text);
    final localizedText = parameters == null
        ? key.tr
        : key.trParams(parameters!);
    final mediaQuery = MediaQuery.of(context);
    final hasFoldHinge = mediaQuery.displayFeatures.any(
      (feature) =>
          feature.type == DisplayFeatureType.hinge ||
          feature.type == DisplayFeatureType.fold,
    );
    final defaultSize = hasFoldHinge
        ? 18.0
        : mediaQuery.size.shortestSide >= 600
        ? 20.0
        : 16.0;

    return Text(
      uppercase ? localizedText.toUpperCase() : localizedText,
      style: (style ?? const TextStyle()).copyWith(
        fontSize: size ?? style?.fontSize ?? defaultSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  String _keyForText(String value) {
    final sourceKey = appTextSourceKeys[value];
    if (sourceKey != null) return sourceKey;
    if (viVn.containsKey(value)) return value;
    for (final entry in viVn.entries) {
      if (entry.value.toLowerCase() == value.toLowerCase()) return entry.key;
    }
    return value;
  }
}
