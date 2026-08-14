import 'package:clone_spotify/data/seed_data.dart';
import 'package:clone_spotify/models/Playlist.dart';
import 'package:clone_spotify/providers/audio_player_provider.dart';
import 'package:clone_spotify/screens/album/album_detail_screen.dart';
import 'package:clone_spotify/screens/artist/artist_detail_screen.dart';
import 'package:clone_spotify/screens/playlist/playlist_detail_screen.dart';
import 'package:clone_spotify/theme/app_colors.dart';
import 'package:clone_spotify/widgets/cover_image.dart';
import 'package:clone_spotify/widgets/horizontal_card_list.dart';
import 'package:clone_spotify/widgets/section_header.dart';
import 'package:clone_spotify/widgets/song_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Chào buổi sáng';
    if (hour < 18) return 'Chào buổi chiều';
    return 'Chào buổi tối';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ================= HEADER =================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.surfaceElevated,
                    child: Icon(
                      Icons.person,
                      color: AppColors.textSecondary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _greeting(),
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ================= QUICK PICKS GRID =================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3.1,
              ),
              delegate: SliverChildBuilderDelegate((context, i) {
                final playlist = allPlaylists[i];
                return _QuickPickTile(playlist: playlist);
              }, childCount: allPlaylists.length),
            ),
          ),

          // ================= POPULAR ARTISTS (browse) =================
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SectionHeader(title: 'Nghệ sĩ nổi bật'),
                HorizontalCardList(
                  items: allArtists
                      .map(
                        (artist) => CardItem(
                          title: artist.name,
                          subtitle: artist.monthlyListeners,
                          imageUrl: artist.imageUrl,
                          circleImage: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ArtistDetailScreen(artist: artist),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          // ================= ALBUM =================
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SectionHeader(title: 'Album của bạn'),
                HorizontalCardList(
                  items: allAlbums
                      .map(
                        (album) => CardItem(
                          title: album.title,
                          subtitle: album.artist,
                          imageUrl: album.imageUrl,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AlbumDetailScreen(album: album),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          // ================= THƯ VIỆN NHẠC LOCAL =================
          const SliverToBoxAdapter(
            child: SectionHeader(title: 'Thư viện nhạc của bạn'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              final song = localSongs[i];
              return SongTile(song: song, index: i, contextQueue: localSongs);
            }, childCount: localSongs.length),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _QuickPickTile extends StatelessWidget {
  final Playlist playlist;

  const _QuickPickTile({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlaylistDetailScreen(playlist: playlist),
            ),
          );
        },
        child: Row(
          children: [
            CoverImage(imageUrl: playlist.imageUrl, size: 56, borderRadius: 4),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                playlist.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.play_arrow,
                color: AppColors.textPrimary,
              ),
              onPressed: () => context.read<AudioPlayerProvider>().playQueue(
                playlist.songs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
