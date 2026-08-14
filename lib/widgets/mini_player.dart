import 'package:clone_spotify/providers/audio_player_provider.dart';
import 'package:clone_spotify/providers/library_provider.dart';
import 'package:clone_spotify/screens/player/now_playing_screen.dart';
import 'package:clone_spotify/theme/app_colors.dart';
import 'package:clone_spotify/widgets/cover_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Thanh player nhỏ luôn hiện phía trên bottom nav khi có bài đang phát.
class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioPlayerProvider>();
    final library = context.watch<LibraryProvider>();

    final song = audio.currentSong;

    if (song == null) {
      return const SizedBox.shrink();
    }

    final progress = audio.duration.inMilliseconds <= 0
        ? 0.0
        : (audio.position.inMilliseconds / audio.duration.inMilliseconds).clamp(
            0.0,
            1.0,
          );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const NowPlayingScreen(),
            transitionsBuilder: (_, animation, __, child) {
              final tween = Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeOutCubic));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        color: AppColors.miniPlayerBg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ==========================================================
            // PROGRESS BAR
            // ==========================================================
            LinearProgressIndicator(
              value: progress,
              minHeight: 2,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(AppColors.textPrimary),
            ),

            // ==========================================================
            // PLAYER CONTENT
            // ==========================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  // ======================================================
                  // COVER
                  // ======================================================
                  CoverImage(
                    imageUrl: song.imageUrl,
                    size: 40,
                    borderRadius: 4,
                  ),

                  const SizedBox(width: 10),

                  // ======================================================
                  // SONG INFO
                  // ======================================================
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          song.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          song.artist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ======================================================
                  // LIKE
                  // ======================================================
                  IconButton(
                    tooltip: library.isLiked(song.id) ? 'Bỏ thích' : 'Thích',
                    icon: Icon(
                      library.isLiked(song.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: library.isLiked(song.id)
                          ? AppColors.green
                          : AppColors.textPrimary,
                      size: 22,
                    ),
                    onPressed: () {
                      context.read<LibraryProvider>().toggleLiked(song);
                    },
                  ),

                  // ======================================================
                  // PREVIOUS
                  // ======================================================
                  IconButton(
                    tooltip: 'Bài trước',
                    icon: const Icon(
                      Icons.skip_previous,
                      color: AppColors.textPrimary,
                      size: 25,
                    ),
                    onPressed: audio.queue.length > 1
                        ? () {
                            context.read<AudioPlayerProvider>().previous();
                          }
                        : null,
                  ),

                  // ======================================================
                  // PLAY / PAUSE
                  // ======================================================
                  IconButton(
                    tooltip: audio.isPlaying ? 'Tạm dừng' : 'Phát',
                    icon: Icon(
                      audio.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: AppColors.textPrimary,
                      size: 28,
                    ),
                    onPressed: () {
                      context.read<AudioPlayerProvider>().togglePlayPause();
                    },
                  ),

                  // ======================================================
                  // NEXT
                  // ======================================================
                  IconButton(
                    tooltip: 'Bài tiếp theo',
                    icon: const Icon(
                      Icons.skip_next,
                      color: AppColors.textPrimary,
                      size: 25,
                    ),
                    onPressed: audio.queue.length > 1
                        ? () {
                            context.read<AudioPlayerProvider>().next();
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
