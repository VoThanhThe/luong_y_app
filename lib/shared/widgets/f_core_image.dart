import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FCoreImage extends StatelessWidget {
  /// Đường dẫn ảnh: Có thể là URL (http/https), Asset Path, hoặc File Path nội bộ
  final String path;

  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final AlignmentGeometry alignment;
  
  /// Widget hiển thị tạm khi đang tải ảnh mạng (Network)
  final Widget? placeholder;
  
  /// Widget hiển thị khi bị lỗi không load được ảnh
  final Widget? errorWidget;

  const FCoreImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.alignment = Alignment.center,
    this.placeholder,
    this.errorWidget,
  });

  // Kiểm tra đuôi file có phải SVG hay không
  bool get _isSvg => path.toLowerCase().endsWith('.svg');

  // Kiểm tra xem có phải ảnh từ Internet hay không
  bool get _isNetwork =>
      path.startsWith('http://') || path.startsWith('https://');

  // Kiểm tra xem có phải file trong bộ nhớ thiết bị (Local File) hay không
  bool get _isFile =>
      path.startsWith('/storage') ||
      path.startsWith('/var/') ||
      path.startsWith('file://');

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return _buildErrorWidget();
    }

    // 🔴 TRƯỜNG HỢP 1: ẢNH MẠNG (NETWORK)
    if (_isNetwork) {
      if (_isSvg) {
        return SvgPicture.network(
          path,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
          placeholderBuilder: (context) => _buildPlaceholder(),
        );
      }
      return Image.network(
        path,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      );
    }

    // 🟡 TRƯỜNG HỢP 2: ẢNH LOCAL FILE (Bộ nhớ máy)
    if (_isFile) {
      final file = File(path.replaceFirst('file://', ''));
      if (_isSvg) {
        return SvgPicture.file(
          file,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
        );
      }
      return Image.file(
        file,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      );
    }

    // 🟢 TRƯỜNG HỢP 3: ẢNH ASSET NỘI BỘ (Mặc định)
    if (_isSvg) {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    }

    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
    );
  }

  // Khung chờ khi load ảnh
  Widget _buildPlaceholder() {
    return placeholder ??
        SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
  }

  // Khung hiển thị khi bị lỗi
  Widget _buildErrorWidget() {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          color: Colors.grey.shade200,
          child: const Icon(
            Icons.broken_image_rounded,
            color: Colors.grey,
            size: 24,
          ),
        );
  }
}