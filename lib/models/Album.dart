import 'package:clone_spotify/models/Song.dart';

class Album {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  final int year;
  final List<Song> songs;

  const Album({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.year,
    required this.songs,
  });
}
