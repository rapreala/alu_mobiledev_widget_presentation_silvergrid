import 'package:flutter/material.dart';
import 'screens/album_grid_screen.dart';

/// Main entry point of the application
void main() {
  runApp(const SpotifyAlbumApp());
}

/// Root widget of the application
/// Configures the app theme and navigation
class SpotifyAlbumApp extends StatelessWidget {
  const SpotifyAlbumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afrobeats Albums',
      debugShowCheckedModeBanner: false,
      // Spotify-inspired dark theme
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF1DB954), // Spotify green
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1DB954),
          secondary: Color(0xFF1DB954),
          surface: Color(0xFF181818),
        ),
        useMaterial3: true,
      ),
      home: const AlbumGridScreen(),
    );
  }
}