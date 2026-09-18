import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FocusNode focusNode;
  final int maxLines;
  final bool autoFocus;
  final String? Function(String?)? validator;
  
  // Bổ sung thêm hỗ trợ cho mật khẩu (hiển thị icon ẩn/hiện)
  final bool isPassword;
  final VoidCallback? onTogglePassword;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.maxLines = 1,
    this.autoFocus = false,
    this.validator,
    this.isPassword = false,
    this.onTogglePassword,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _hasText = widget.controller.text.isNotEmpty;
    widget.controller.addListener(_updateTextStatus);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateTextStatus);
    super.dispose();
  }

  void _updateTextStatus() {
    if (mounted) {
      setState(() {
        _hasText = widget.controller.text.isNotEmpty;
      });
    }
  }

  void _clearText() {
    widget.controller.clear();
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Itim',
              color: AppColors.grayDarkColor,
            ),
            children: [
              TextSpan(
                text: widget.validator != null ? ' *' : '',
                style: TextStyle(
                  color: AppColors.redColor,
                  fontSize: 16,
                  fontFamily: 'Itim',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: widget.keyboardType == TextInputType.text
              ? TextCapitalization.words
              : TextCapitalization.none,
          inputFormatters: widget.keyboardType == TextInputType.phone
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          obscureText: widget.obscureText,
          autofocus: widget.autoFocus,
          onChanged: widget.onChanged,
          cursorColor: AppColors.grayDarkColor,
          focusNode: widget.focusNode,
          maxLines: widget.maxLines,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Itim',
            color: AppColors.grayDarkColor,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Itim',
              color: AppColors.grayDarkColor.withAlpha((0.34 * 255).round()),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.grayDarkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.redColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.redColor, width: 1.5),
            ),
            errorStyle: TextStyle(
              fontFamily: 'Itim',
              color: AppColors.redColor,
            ),
            // Xử lý suffixIcon thông minh: Nếu là mật khẩu ưu tiên hiển thị nút ẩn/hiện, ngược lại hiển thị nút xóa nhanh
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      widget.obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.grayDarkColor,
                    ),
                    onPressed: widget.onTogglePassword,
                  )
                : (_hasText
                    ? IconButton(
                        icon: Icon(Icons.highlight_off, color: AppColors.grayDarkColor),
                        onPressed: _clearText,
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}