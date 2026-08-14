import 'package:clone_spotify/models/Song.dart';
import 'package:clone_spotify/providers/audio_player_provider.dart';
import 'package:clone_spotify/providers/library_provider.dart';
import 'package:clone_spotify/theme/app_colors.dart';
import 'package:clone_spotify/widgets/cover_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final int index;
  final List<Song> contextQueue;
  final bool showAlbum;
  final bool showImage;

  const SongTile({
    super.key,
    required this.song,
    required this.index,
    required this.contextQueue,
    this.showAlbum = false,
    this.showImage = true,
  });

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioPlayerProvider>();
    final library = context.watch<LibraryProvider>();
    final isCurrent = audio.currentSong?.id == song.id;

    return InkWell(
      onTap: () {
        debugPrint('==============================');
        debugPrint('CLICK: ${song.title}');
        debugPrint('INDEX: $index');
        debugPrint('QUEUE LENGTH: ${contextQueue.length}');
        debugPrint('AUDIO: ${song.audioUrl}');
        debugPrint('==============================');

        context.read<AudioPlayerProvider>().playQueue(
          contextQueue,
          startIndex: index,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            if (showImage) ...[
              CoverImage(imageUrl: song.imageUrl, size: 48, borderRadius: 4),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isCurrent) ...[
                        Icon(
                          audio.isPlaying
                              ? Icons.volume_up_rounded
                              : Icons.pause_circle_outline,
                          color: AppColors.green,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                      ],
                      Expanded(
                        child: Text(
                          song.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isCurrent
                                ? AppColors.green
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    showAlbum ? '${song.artist} • ${song.album}' : song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                library.isLiked(song.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: library.isLiked(song.id)
                    ? AppColors.green
                    : AppColors.textSecondary,
                size: 20,
              ),
              onPressed: () =>
                  context.read<LibraryProvider>().toggleLiked(song),
            ),
            const Icon(
              Icons.more_vert,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
