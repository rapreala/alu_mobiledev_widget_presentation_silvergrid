import 'package:flutter/material.dart';

/// Main entry point of the application
void main() {
  runApp(const SpotifyAlbumApp());
}

/// Root widget of the application
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

/// Main screen displaying Afrobeats albums using SliverGrid
class AlbumGridScreen extends StatelessWidget {
  const AlbumGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // CustomScrollView allows combining multiple scrollable widgets
        slivers: [
          // Spotify-style app bar
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF121212),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Afrobeats Albums',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: false,
            ),
          ),
          
          // Padding before grid
          const SliverPadding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          ),
          
          // ========================================
          // MAIN WIDGET: SliverGrid
          // ========================================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              // PROPERTY 1: gridDelegate
              // Controls HOW albums are laid out in the grid
              // Defines columns, spacing, and item dimensions
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,           // Number of columns (2 for album style)
                mainAxisSpacing: 20.0,       // Vertical space between albums
                crossAxisSpacing: 16.0,      // Horizontal space between albums
                childAspectRatio: 0.75,      // Width/Height ratio (taller cards)
              ),
              
              // PROPERTY 2: delegate
              // Provides the CHILDREN (album cards) for the grid
              // Uses builder for efficiency - only creates visible items
              delegate: SliverChildBuilderDelegate(
                // This function is called for each album
                (BuildContext context, int index) {
                  final album = _afrobeatsAlbums[index];
                  return AlbumCard(
                    albumName: album['album']!,
                    artistName: album['artist']!,
                    color: album['color'] as Color,
                  );
                },
                // PROPERTY 3: childCount
                // Total NUMBER of albums in the grid
                childCount: _afrobeatsAlbums.length,  // Dynamic based on album list
              ),
            ),
          ),
          
          // Bottom padding
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 24),
          ),
        ],
      ),
    );
  }

  /// Afrobeats albums database
  /// Contains popular Afrobeats albums with their artists and theme colors
  static final List<Map<String, dynamic>> _afrobeatsAlbums = [
    {'album': 'Made in Lagos', 'artist': 'Wizkid', 'color': const Color(0xFFE74C3C)},
    {'album': 'African Giant', 'artist': 'Burna Boy', 'color': const Color(0xFF3498DB)},
    {'album': 'A Better Time', 'artist': 'Davido', 'color': const Color(0xFF9B59B6)},
    {'album': 'Love, Damini', 'artist': 'Burna Boy', 'color': const Color(0xFFE67E22)},
    {'album': 'More Love Less Ego', 'artist': 'Wizkid', 'color': const Color(0xFF1ABC9C)},
    {'album': 'Timeless', 'artist': 'Davido', 'color': const Color(0xFFF39C12)},
    {'album': 'Boy Alone', 'artist': 'Omah Lay', 'color': const Color(0xFF8E44AD)},
    {'album': 'Playboy', 'artist': 'Fireboy DML', 'color': const Color(0xFFE74C3C)},
    {'album': '19 & Dangerous', 'artist': 'Ayra Starr', 'color': const Color(0xFFEC407A)},
    {'album': 'Rave & Roses', 'artist': 'Rema', 'color': const Color(0xFF2ECC71)},
    {'album': 'Mr Money With The Vibe', 'artist': 'Asake', 'color': const Color(0xFFFF5722)},
    {'album': 'The Year I Turned 21', 'artist': 'Ayra Starr', 'color': const Color(0xFF9C27B0)},
    {'album': 'Work of Art', 'artist': 'Asake', 'color': const Color(0xFFFFC107)},
    {'album': 'Twice as Tall', 'artist': 'Burna Boy', 'color': const Color(0xFF00BCD4)},
    {'album': 'Colours and Sounds', 'artist': 'Tems', 'color': const Color(0xFF673AB7)},
    {'album': 'Apollo', 'artist': 'Fireboy DML', 'color': const Color(0xFFFF6F00)},
  ];
}

/// Individual album card widget
/// Displays a single album with cover, title, and artist
class AlbumCard extends StatelessWidget {
  final String albumName;
  final String artistName;
  final Color color;

  const AlbumCard({
    super.key,
    required this.albumName,
    required this.artistName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Album cover art (simulated with colored container)
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              // Gradient background simulating album art
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color.withOpacity(0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.album,
                size: 64,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        
        // Album name
        Text(
          albumName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        
        // Artist name
        Text(
          artistName,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 13,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}