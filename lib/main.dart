import 'package:flutter/material.dart';
import 'package:clone_spotify/screens/home/first_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clone Spotify',
      debugShowCheckedModeBanner: false, // 👈 thêm dòng này
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),

      // Trang đầu tiên khi mở app
      home: const FirstHome(),
    );
  }
}
