import 'package:clone_spotify/data/seed_data.dart';
import 'package:clone_spotify/models/Artist.dart';
import 'package:clone_spotify/models/Song.dart';
import 'package:clone_spotify/screens/artist/artist_detail_screen.dart';
import 'package:clone_spotify/theme/app_colors.dart';
import 'package:clone_spotify/widgets/cover_image.dart';
import 'package:clone_spotify/widgets/song_tile.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();

    final List<Song> matchedSongs = query.isEmpty
        ? []
        : allSongs
            .where((s) => s.title.toLowerCase().contains(query))
            .toList();

    final List<Artist> matchedArtists = query.isEmpty
        ? []
        : allArtists
            .where((a) => a.name.toLowerCase().contains(query))
            .toList();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _controller,
              onChanged: (v) => setState(() => _query = v),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Bạn muốn nghe gì?',
                hintStyle: const TextStyle(color: Colors.black54),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _query = '');
                        },
                      ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: query.isEmpty
                ? _BrowseAll()
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      if (matchedArtists.isNotEmpty) ...[
                        const _ResultHeader(title: 'Nghệ sĩ'),
                        ...matchedArtists.map(
                          (artist) => ListTile(
                            leading: CoverImage(
                              imageUrl: artist.imageUrl,
                              size: 44,
                              circle: true,
                            ),
                            title: Text(
                              artist.name,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            subtitle: const Text(
                              'Nghệ sĩ',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
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
                        ),
                      ],
                      if (matchedSongs.isNotEmpty) ...[
                        const _ResultHeader(title: 'Bài hát'),
                        ...matchedSongs.asMap().entries.map(
                          (e) => SongTile(
                            song: e.value,
                            index: matchedSongs.indexOf(e.value),
                            contextQueue: matchedSongs,
                          ),
                        ),
                      ],
                      if (matchedArtists.isEmpty && matchedSongs.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: Center(
                            child: Text(
                              'Không tìm thấy kết quả phù hợp',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _ResultHeader extends StatelessWidget {
  final String title;
  const _ResultHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// Trạng thái duyệt mặc định khi ô tìm kiếm còn trống: hiện lưới thể loại
/// đơn giản dựa trên nghệ sĩ nổi bật để giao diện đỡ trống trải.
class _BrowseAll extends StatelessWidget {
  static const _colors = [
    Color(0xFF8C1932),
    Color(0xFF1E3264),
    Color(0xFF477D95),
    Color(0xFF7358FF),
    Color(0xFFE8115B),
    Color(0xFF509BF5),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemCount: allArtists.length,
      itemBuilder: (context, i) {
        final artist = allArtists[i];
        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArtistDetailScreen(artist: artist),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _colors[i % _colors.length],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Text(
                  artist.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Positioned(
                  right: -8,
                  bottom: -8,
                  child: Transform.rotate(
                    angle: 0.35,
                    child: CoverImage(
                      imageUrl: artist.imageUrl,
                      size: 60,
                      borderRadius: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
