import 'package:clone_spotify/data/seed_data.dart';
import 'package:clone_spotify/models/Song.dart';
import 'package:flutter/material.dart';

/// Quản lý thư viện cá nhân: bài hát đã thích, playlist / album đã lưu,
/// nghệ sĩ đang theo dõi.
class LibraryProvider extends ChangeNotifier {
  final Set<String> _likedSongIds = allSongs.take(4).map((s) => s.id).toSet();
  final Set<String> _savedPlaylistIds = {'p1'};
  final Set<String> _savedAlbumIds = {'al_local'};
  final Set<String> _followedArtistIds = <String>{};

  bool isLiked(String songId) => _likedSongIds.contains(songId);

  void toggleLiked(Song song) {
    if (_likedSongIds.contains(song.id)) {
      _likedSongIds.remove(song.id);
    } else {
      _likedSongIds.add(song.id);
    }
    notifyListeners();
  }

  List<Song> get likedSongs =>
      allSongs.where((s) => _likedSongIds.contains(s.id)).toList();

  bool isPlaylistSaved(String id) => _savedPlaylistIds.contains(id);
  void togglePlaylistSaved(String id) {
    if (!_savedPlaylistIds.remove(id)) _savedPlaylistIds.add(id);
    notifyListeners();
  }

  bool isAlbumSaved(String id) => _savedAlbumIds.contains(id);
  void toggleAlbumSaved(String id) {
    if (!_savedAlbumIds.remove(id)) _savedAlbumIds.add(id);
    notifyListeners();
  }

  bool isArtistFollowed(String id) => _followedArtistIds.contains(id);
  void toggleArtistFollowed(String id) {
    if (!_followedArtistIds.remove(id)) _followedArtistIds.add(id);
    notifyListeners();
  }

  Set<String> get savedPlaylistIds => _savedPlaylistIds;
  Set<String> get savedAlbumIds => _savedAlbumIds;
  Set<String> get followedArtistIds => _followedArtistIds;
}
