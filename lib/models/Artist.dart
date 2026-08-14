import 'package:clone_spotify/models/Song.dart';

class Artist {
  final String id;
  final String name;
  final String imageUrl;
  final String monthlyListeners;
  final List<Song> topSongs;

  const Artist({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.monthlyListeners,
    required this.topSongs,
  });
}
