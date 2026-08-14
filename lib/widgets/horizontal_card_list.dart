import 'package:clone_spotify/theme/app_colors.dart';
import 'package:clone_spotify/widgets/cover_image.dart';
import 'package:flutter/material.dart';

class CardItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool circleImage;
  final VoidCallback onTap;

  CardItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onTap,
    this.circleImage = false,
  });
}

class HorizontalCardList extends StatelessWidget {
  final List<CardItem> items;

  const HorizontalCardList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          final item = items[i];
          return GestureDetector(
            onTap: item.onTap,
            child: SizedBox(
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CoverImage(
                    imageUrl: item.imageUrl,
                    size: 140,
                    circle: item.circleImage,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
