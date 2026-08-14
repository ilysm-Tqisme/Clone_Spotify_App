import 'package:clone_spotify/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Ảnh bìa dùng chung cho Song / Album / Playlist / Artist.
///
/// Nếu [imageUrl] trống (trường hợp 9 bài nhạc local không có ảnh bìa riêng)
/// thì vẽ một khối gradient kèm icon nốt nhạc thay vì crash hoặc để trống.
class CoverImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final double borderRadius;
  final bool circle;

  const CoverImage({
    super.key,
    required this.imageUrl,
    required this.size,
    this.borderRadius = 6,
    this.circle = false,
  });

  @override
  Widget build(BuildContext context) {
    final radius = circle ? size / 2 : borderRadius;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: imageUrl.isEmpty
          ? _placeholder()
          : Image.asset(
              imageUrl,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _placeholder(),
            ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceElevated, Color(0xFF1F3A2E)],
        ),
      ),
      child: Icon(
        Icons.music_note_rounded,
        color: AppColors.textSecondary,
        size: size * 0.4,
      ),
    );
  }
}
