import 'package:clone_spotify/providers/audio_player_provider.dart';
import 'package:clone_spotify/providers/library_provider.dart';
import 'package:clone_spotify/theme/app_colors.dart';
import 'package:clone_spotify/widgets/cover_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

/// Màn phát nhạc toàn màn hình, kéo xuống để đóng — giống "Now Playing"
/// của Spotify.
class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioPlayerProvider>();
    final library = context.watch<LibraryProvider>();
    final song = audio.currentSong;

    if (song == null) {
      // Không có bài nào đang phát -> tự đóng màn hình.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.canPop(context)) Navigator.pop(context);
      });
      return const Scaffold(backgroundColor: AppColors.background);
    }

    final duration = audio.duration;
    final position = audio.position > duration
        ? duration
        : audio.position < Duration.zero
        ? Duration.zero
        : audio.position;
    final liked = library.isLiked(song.id);

    return GestureDetector(
      onVerticalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) > 250) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1E1E1E),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 8),
                // ================= HEADER =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_down, size: 30),
                      color: AppColors.textPrimary,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Column(
                      children: [
                        const Text(
                          'ĐANG PHÁT TỪ THƯ VIỆN',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          song.album,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.more_vert, color: AppColors.textPrimary),
                  ],
                ),
                const SizedBox(height: 28),
                // ================= COVER =================
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CoverImage(
                        imageUrl: song.imageUrl,
                        size: double.infinity,
                        borderRadius: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // ================= TITLE + LIKE =================
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            song.artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        liked ? Icons.favorite : Icons.favorite_border,
                        color: liked ? AppColors.green : AppColors.textPrimary,
                        size: 26,
                      ),
                      onPressed: () =>
                          context.read<LibraryProvider>().toggleLiked(song),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // ================= SEEK BAR =================
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 14,
                    ),
                    activeTrackColor: AppColors.textPrimary,
                    inactiveTrackColor: Colors.white24,
                    thumbColor: AppColors.textPrimary,
                  ),
                  child: Slider(
                    min: 0,
                    max: duration.inMilliseconds > 0
                        ? duration.inMilliseconds.toDouble()
                        : 1,
                    value: position.inMilliseconds
                        .clamp(0, duration.inMilliseconds)
                        .toDouble(),
                    onChanged: (value) {
                      context.read<AudioPlayerProvider>().seek(
                        Duration(milliseconds: value.toInt()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(position),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _formatDuration(duration),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // ================= CONTROLS =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.shuffle,
                        color: audio.shuffleOn
                            ? AppColors.green
                            : AppColors.textSecondary,
                        size: 22,
                      ),
                      onPressed: () =>
                          context.read<AudioPlayerProvider>().toggleShuffle(),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.skip_previous,
                        color: AppColors.textPrimary,
                        size: 36,
                      ),
                      onPressed: () =>
                          context.read<AudioPlayerProvider>().previous(),
                    ),
                    GestureDetector(
                      onTap: () =>
                          context.read<AudioPlayerProvider>().togglePlayPause(),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: AppColors.textPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          audio.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.black,
                          size: 34,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.skip_next,
                        color: AppColors.textPrimary,
                        size: 36,
                      ),
                      onPressed: () =>
                          context.read<AudioPlayerProvider>().next(),
                    ),
                    IconButton(
                      icon: Icon(
                        audio.loopMode == LoopMode.one
                            ? Icons.repeat_one
                            : Icons.repeat,
                        color: audio.loopMode == LoopMode.off
                            ? AppColors.textSecondary
                            : AppColors.green,
                        size: 22,
                      ),
                      onPressed: () =>
                          context.read<AudioPlayerProvider>().cycleRepeatMode(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
