import 'package:flutter/material.dart';
import 'package:spotify/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Clone',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        canvasColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF121212),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFF7A7A7A),
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: Theme.of(context).textTheme
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
      home: const HomePage(),
    );
  }
}
