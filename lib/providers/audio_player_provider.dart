import 'package:clone_spotify/models/Song.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  List<Song> _queue = [];
  int _currentIndex = 0;

  bool _shuffleOn = false;
  List<int> _shuffleOrder = [];

  AudioPlayerProvider() {
    _player.playerStateStream.listen((state) {
      notifyListeners();

      if (state.processingState == ProcessingState.completed) {
        _onTrackCompleted();
      }
    });

    _player.positionStream.listen((_) {
      notifyListeners();
    });
  }

  // ============================================================
  // GETTERS
  // ============================================================

  AudioPlayer get player => _player;

  List<Song> get queue => List.unmodifiable(_queue);

  int get currentIndex => _currentIndex;

  bool get shuffleOn => _shuffleOn;

  bool get isPlaying => _player.playing;

  Duration get position => _player.position;

  Duration get duration => _player.duration ?? Duration.zero;

  LoopMode get loopMode => _player.loopMode;

  Song? get currentSong {
    if (_queue.isEmpty) return null;

    if (_currentIndex < 0 || _currentIndex >= _queue.length) {
      return null;
    }

    return _queue[_currentIndex];
  }

  bool get hasTrack => currentSong != null;

  // ============================================================
  // PLAY QUEUE
  // ============================================================

  /// Phát danh sách bài hát từ index được chọn.
  ///
  /// Ví dụ:
  /// playQueue(localSongs, startIndex: 2)
  ///
  /// => phát bài số 3 nhưng queue vẫn giữ đủ 9 bài.
  Future<void> playQueue(List<Song> songs, {int startIndex = 0}) async {
    if (songs.isEmpty) return;

    _queue = List<Song>.from(songs);

    if (startIndex < 0) {
      startIndex = 0;
    }

    if (startIndex >= _queue.length) {
      startIndex = _queue.length - 1;
    }

    _currentIndex = startIndex;

    _shuffleOrder = List.generate(_queue.length, (index) => index);

    if (_shuffleOn) {
      _shuffleOrder.shuffle();
    }

    notifyListeners();

    await _loadAndPlayCurrent();
  }

  // ============================================================
  // PLAY CURRENT
  // ============================================================

  Future<void> _loadAndPlayCurrent() async {
    final song = currentSong;

    if (song == null) return;

    try {
      debugPrint(
        'PLAY: ${song.title} | index=$_currentIndex | asset=${song.audioUrl}',
      );

      await _player.stop();

      await _player.setAsset(song.audioUrl);

      notifyListeners();

      await _player.play();

      notifyListeners();
    } catch (e, stackTrace) {
      debugPrint('========== PLAYBACK ERROR ==========');
      debugPrint('Song: ${song.title}');
      debugPrint('Index: $_currentIndex');
      debugPrint('Asset: ${song.audioUrl}');
      debugPrint('Error: $e');
      debugPrint('$stackTrace');
      debugPrint('====================================');
    }
  }

  // ============================================================
  // PLAY / PAUSE
  // ============================================================

  Future<void> togglePlayPause() async {
    if (currentSong == null) return;

    if (_player.playing) {
      await _player.pause();
    } else {
      if (_player.processingState == ProcessingState.idle) {
        await _loadAndPlayCurrent();
      } else {
        await _player.play();
      }
    }

    notifyListeners();
  }

  // ============================================================
  // NEXT
  // ============================================================

  Future<void> next() async {
    if (_queue.isEmpty) return;

    if (_shuffleOn) {
      final currentShufflePosition = _shuffleOrder.indexOf(_currentIndex);

      final nextShufflePosition =
          (currentShufflePosition + 1) % _shuffleOrder.length;

      _currentIndex = _shuffleOrder[nextShufflePosition];
    } else {
      if (_currentIndex < _queue.length - 1) {
        _currentIndex++;
      } else {
        // Hết bài -> quay lại bài đầu.
        _currentIndex = 0;
      }
    }

    notifyListeners();

    await _loadAndPlayCurrent();
  }

  // ============================================================
  // PREVIOUS
  // ============================================================

  Future<void> previous() async {
    if (_queue.isEmpty) return;

    // Nếu bài đang phát > 3 giây
    // thì Previous sẽ tua về đầu bài.
    if (_player.position.inSeconds > 3) {
      await _player.seek(Duration.zero);
      return;
    }

    if (_shuffleOn) {
      final currentShufflePosition = _shuffleOrder.indexOf(_currentIndex);

      final previousShufflePosition =
          (currentShufflePosition - 1 + _shuffleOrder.length) %
          _shuffleOrder.length;

      _currentIndex = _shuffleOrder[previousShufflePosition];
    } else {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = _queue.length - 1;
      }
    }

    notifyListeners();

    await _loadAndPlayCurrent();
  }

  // ============================================================
  // PLAY AT INDEX
  // ============================================================

  Future<void> playAt(int index) async {
    if (_queue.isEmpty) return;

    if (index < 0 || index >= _queue.length) return;

    _currentIndex = index;

    notifyListeners();

    await _loadAndPlayCurrent();
  }

  // ============================================================
  // SEEK
  // ============================================================

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  // ============================================================
  // SHUFFLE
  // ============================================================

  void toggleShuffle() {
    _shuffleOn = !_shuffleOn;

    _shuffleOrder = List.generate(_queue.length, (index) => index);

    if (_shuffleOn) {
      _shuffleOrder.shuffle();
    }

    notifyListeners();
  }

  // ============================================================
  // REPEAT
  // ============================================================

  Future<void> cycleRepeatMode() async {
    switch (_player.loopMode) {
      case LoopMode.off:
        await _player.setLoopMode(LoopMode.all);
        break;

      case LoopMode.all:
        await _player.setLoopMode(LoopMode.one);
        break;

      case LoopMode.one:
        await _player.setLoopMode(LoopMode.off);
        break;
    }

    notifyListeners();
  }

  // ============================================================
  // TRACK COMPLETED
  // ============================================================

  Future<void> _onTrackCompleted() async {
    if (_player.loopMode == LoopMode.one) {
      await _player.seek(Duration.zero);
      await _player.play();
      return;
    }

    // Nếu hết queue và repeat OFF -> dừng.
    if (!_shuffleOn &&
        _currentIndex == _queue.length - 1 &&
        _player.loopMode == LoopMode.off) {
      notifyListeners();
      return;
    }

    await next();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
