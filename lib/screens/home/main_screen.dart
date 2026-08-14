import 'package:clone_spotify/screens/home/home_screen.dart';
import 'package:clone_spotify/screens/library/library_screen.dart';
import 'package:clone_spotify/screens/search/search_screen.dart';
import 'package:clone_spotify/theme/app_colors.dart';
import 'package:clone_spotify/widgets/mini_player.dart';
import 'package:flutter/material.dart';

/// Khung điều hướng chính của app sau khi đăng nhập/đăng ký:
/// Home / Search / Library + mini player ghim phía trên bottom nav.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  static const _tabs = [HomeScreen(), SearchScreen(), LibraryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniPlayer(),
          BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            backgroundColor: const Color(0xFF181818),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.textPrimary,
            unselectedItemColor: AppColors.textSecondary,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music_outlined),
                activeIcon: Icon(Icons.library_music),
                label: 'Your Library',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
