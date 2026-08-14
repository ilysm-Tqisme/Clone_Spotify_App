// ============================================================================
// SEED DATA
// ----------------------------------------------------------------------------
// Dữ liệu mẫu cho toàn bộ app.
//
// `localSongs` trỏ thẳng tới 9 file mp3 thật nằm trong lib/assets/musics/.
// Tên file trên đĩa đã được đổi sang dạng an toàn (không dấu, không khoảng
// trắng, không ký tự đặc biệt) để build Flutter (Android/iOS/Web) không bị
// lỗi encode đường dẫn asset. Tên gốc (có dấu / có ký tự Trung) vẫn được giữ
// nguyên ở trường `title` để hiển thị trong app.
//
//   Tên gốc                                          -> Tên file an toàn
//   Ai Ngoài Anh                                      -> ai_ngoai_anh.mp3
//   Dạo Bước Hongkong 1999 _ 漫步香港1999               -> dao_buoc_hongkong_1999_1999.mp3
//   Fading Light _渐暗的光                              -> fading_light.mp3
//   Hẹn em dưới pháo hoa                               -> hen_em_duoi_phao_hoa.mp3
//   Nghe kể năm 90s                                    -> nghe_ke_nam_90s.mp3
//   Người Im Lặng Gặp Người Hay Nói                    -> nguoi_im_lang_gap_nguoi_hay_noi.mp3
//   So Well                                            -> so_well.mp3
//   Vườn mây vừa hay                                   -> vuon_may_vua_hay.mp3
//   Yêu qua mạng                                       -> yeu_qua_mang.mp3
// ============================================================================

import 'package:clone_spotify/models/Album.dart';
import 'package:clone_spotify/models/Artist.dart';
import 'package:clone_spotify/models/Playlist.dart';
import 'package:clone_spotify/models/Song.dart';

const String _musicDir = 'lib/assets/musics';
const String _artistDir = 'lib/assets/images/artists';

/// 9 bài hát local thật, phát trực tiếp từ asset bundle của app.
/// `imageUrl` để trống -> UI sẽ tự vẽ ảnh bìa placeholder (xem CoverImage).
final List<Song> localSongs = [
  const Song(
    id: 'ls1',
    title: 'Ai Ngoài Anh',
    artist: 'Thư viện của bạn',
    album: 'Nhạc của tôi',
    imageUrl: '',
    audioUrl: '$_musicDir/ai_ngoai_anh.mp3',
  ),
  const Song(
    id: 'ls2',
    title: 'Dạo Bước Hongkong 1999 _ 漫步香港1999',
    artist: 'Thư viện của bạn',
    album: 'Nhạc của tôi',
    imageUrl: '',
    audioUrl: '$_musicDir/dao_buoc_hongkong_1999_1999.mp3',
  ),
  const Song(
    id: 'ls3',
    title: 'Fading Light _渐暗的光',
    artist: 'Thư viện của bạn',
    album: 'Nhạc của tôi',
    imageUrl: '',
    audioUrl: '$_musicDir/fading_light.mp3',
  ),
  const Song(
    id: 'ls4',
    title: 'Hẹn em dưới pháo hoa',
    artist: 'Thư viện của bạn',
    album: 'Nhạc của tôi',
    imageUrl: '',
    audioUrl: '$_musicDir/hen_em_duoi_phao_hoa.mp3',
  ),
  const Song(
    id: 'ls5',
    title: 'Nghe kể năm 90s',
    artist: 'Thư viện của bạn',
    album: 'Nhạc của tôi',
    imageUrl: '',
    audioUrl: '$_musicDir/nghe_ke_nam_90s.mp3',
  ),
  const Song(
    id: 'ls6',
    title: 'Người Im Lặng Gặp Người Hay Nói',
    artist: 'Thư viện của bạn',
    album: 'Nhạc của tôi',
    imageUrl: '',
    audioUrl: '$_musicDir/nguoi_im_lang_gap_nguoi_hay_noi.mp3',
  ),
  const Song(
    id: 'ls7',
    title: 'So Well',
    artist: 'Thư viện của bạn',
    album: 'Nhạc của tôi',
    imageUrl: '',
    audioUrl: '$_musicDir/so_well.mp3',
  ),
  const Song(
    id: 'ls8',
    title: 'Vườn mây vừa hay',
    artist: 'Thư viện của bạn',
    album: 'Nhạc của tôi',
    imageUrl: '',
    audioUrl: '$_musicDir/vuon_may_vua_hay.mp3',
  ),
  const Song(
    id: 'ls9',
    title: 'Yêu qua mạng',
    artist: 'Thư viện của bạn',
    album: 'Nhạc của tôi',
    imageUrl: '',
    audioUrl: '$_musicDir/yeu_qua_mang.mp3',
  ),
];

/// Tất cả bài hát mà app biết tới. LibraryProvider và các màn tìm kiếm
/// đều lấy dữ liệu từ danh sách này.
List<Song> get allSongs => localSongs;

/// Album duy nhất gom toàn bộ 9 bài hát local lại.
final Album localAlbum = Album(
  id: 'al_local',
  title: 'Nhạc của tôi',
  artist: 'Thư viện của bạn',
  imageUrl: '',
  year: 2026,
  songs: localSongs,
);

final List<Album> allAlbums = [localAlbum];

/// Vài playlist dựng từ đúng 9 bài hát local (không bịa thêm bài ngoài).
final List<Playlist> allPlaylists = [
  Playlist(
    id: 'p1',
    title: 'Tất cả nhạc của bạn',
    description: 'Toàn bộ 9 bài hát local trong máy của bạn.',
    imageUrl: '',
    songs: localSongs,
    owner: 'Bạn',
  ),
  Playlist(
    id: 'p2',
    title: 'Nhạc nhẹ nhàng',
    description: 'Những bản nhẹ nhàng để thư giãn.',
    imageUrl: '',
    songs: [localSongs[2], localSongs[6], localSongs[7], localSongs[0]],
    owner: 'Bạn',
  ),
  Playlist(
    id: 'p3',
    title: 'Hoài niệm',
    description: 'Giai điệu gợi nhớ những năm tháng cũ.',
    imageUrl: '',
    songs: [localSongs[4], localSongs[1], localSongs[5], localSongs[3]],
    owner: 'Bạn',
  ),
];

/// Nghệ sĩ nổi bật để duyệt (mang tính minh hoạ giao diện "Browse" kiểu
/// Spotify). Vì app chỉ có 9 file nhạc local thật của bạn, các nghệ sĩ này
/// chưa có bài hát nào phát được (topSongs rỗng) — màn Artist detail sẽ
/// hiển thị trạng thái trống thay vì bịa ra bài hát không có thật.
final List<Artist> allArtists = [
  const Artist(
    id: 'ar1',
    name: 'Taylor Swift',
    imageUrl: '$_artistDir/taylor_swift.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar2',
    name: 'The Weeknd',
    imageUrl: '$_artistDir/the_weeknd.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar3',
    name: 'Billie Eilish',
    imageUrl: '$_artistDir/billie_eilish.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar4',
    name: 'Ed Sheeran',
    imageUrl: '$_artistDir/ed_sheeran.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar5',
    name: 'Ariana Grande',
    imageUrl: '$_artistDir/ariana_grande.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar6',
    name: 'Dua Lipa',
    imageUrl: '$_artistDir/dua_lipa.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar7',
    name: 'Bruno Mars',
    imageUrl: '$_artistDir/bruno_mars.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar8',
    name: 'BTS',
    imageUrl: '$_artistDir/bts.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar9',
    name: 'Drake',
    imageUrl: '$_artistDir/drake.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar10',
    name: 'Rihanna',
    imageUrl: '$_artistDir/rihanna.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar11',
    name: 'Sabrina Carpenter',
    imageUrl: '$_artistDir/sabrina_carpenter.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
  const Artist(
    id: 'ar12',
    name: 'SZA',
    imageUrl: '$_artistDir/sza.jpg',
    monthlyListeners: 'Nghệ sĩ nổi bật',
    topSongs: [],
  ),
];
