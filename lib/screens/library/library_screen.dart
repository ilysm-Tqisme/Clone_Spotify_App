import 'package:clone_spotify/data/seed_data.dart';
import 'package:clone_spotify/models/Playlist.dart';
import 'package:clone_spotify/providers/library_provider.dart';
import 'package:clone_spotify/screens/album/album_detail_screen.dart';
import 'package:clone_spotify/screens/artist/artist_detail_screen.dart';
import 'package:clone_spotify/screens/playlist/playlist_detail_screen.dart';
import 'package:clone_spotify/theme/app_colors.dart';
import 'package:clone_spotify/widgets/cover_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();

    final savedPlaylists =
        allPlaylists.where((p) => library.isPlaylistSaved(p.id)).toList();
    final savedAlbums =
        allAlbums.where((a) => library.isAlbumSaved(a.id)).toList();
    final followedArtists =
        allArtists.where((a) => library.isArtistFollowed(a.id)).toList();

    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Thư viện của bạn',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.add, color: AppColors.textPrimary),
              ],
            ),
          ),

          // ---- Liked songs ----
          _LibraryRow(
            leadingGradient: true,
            title: 'Bài hát đã thích',
            subtitle: '${library.likedSongs.length} bài hát',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PlaylistDetailScreen(
                  playlist: _likedSongsAsPlaylist(library),
                ),
              ),
            ),
          ),

          for (final playlist in savedPlaylists)
            _LibraryRow(
              imageUrl: playlist.imageUrl,
              title: playlist.title,
              subtitle: 'Playlist • ${playlist.owner}',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlaylistDetailScreen(playlist: playlist),
                ),
              ),
            ),

          for (final album in savedAlbums)
            _LibraryRow(
              imageUrl: album.imageUrl,
              title: album.title,
              subtitle: 'Album • ${album.artist}',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AlbumDetailScreen(album: album),
                ),
              ),
            ),

          for (final artist in followedArtists)
            _LibraryRow(
              imageUrl: artist.imageUrl,
              circle: true,
              title: artist.name,
              subtitle: 'Nghệ sĩ',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArtistDetailScreen(artist: artist),
                ),
              ),
            ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Bọc danh sách "bài hát đã thích" thành 1 Playlist tạm để tái dùng
/// PlaylistDetailScreen.
Playlist _likedSongsAsPlaylist(LibraryProvider library) {
  return Playlist(
    id: 'liked',
    title: 'Bài hát đã thích',
    description: 'Những bài hát bạn đã thích.',
    imageUrl: '',
    songs: library.likedSongs,
    owner: 'Bạn',
  );
}

class _LibraryRow extends StatelessWidget {
  final String? imageUrl;
  final bool leadingGradient;
  final bool circle;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LibraryRow({
    this.imageUrl,
    this.leadingGradient = false,
    this.circle = false,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: leadingGradient
          ? Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF450AF5), Color(0xFFC4EFD9)],
                ),
              ),
              child: const Icon(Icons.favorite, color: Colors.white, size: 22),
            )
          : CoverImage(
              imageUrl: imageUrl ?? '',
              size: 48,
              borderRadius: 4,
              circle: circle,
            ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      ),
    );
  }
}
