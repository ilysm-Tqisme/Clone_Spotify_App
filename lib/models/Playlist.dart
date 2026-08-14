import 'package:clone_spotify/models/Song.dart';

class Playlist {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<Song> songs;
  final String owner;

  const Playlist({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.songs,
    this.owner = 'Spotify',
  });
}
