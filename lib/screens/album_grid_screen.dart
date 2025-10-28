import 'package:flutter/material.dart';
import '../data/albums_data.dart';
import '../widgets/album_card.dart';
import '../constants/app_colors.dart';

/// Main screen displaying Afrobeats albums using SliverGrid
/// Demonstrates the three key properties of SliverGrid widget
class AlbumGridScreen extends StatelessWidget {
  const AlbumGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // CustomScrollView allows combining multiple scrollable widgets
        slivers: [
          // Spotify-style app bar that stays pinned while scrolling
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.darkBackground,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'Afrobeats Albums',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: false,
            ),
          ),
          
          // Top padding
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
                crossAxisCount: 2,           // Number of columns (2 for album style)
                mainAxisSpacing: 20.0,       // Vertical space between albums
                crossAxisSpacing: 16.0,      // Horizontal space between albums
                childAspectRatio: 0.75,      // Width/Height ratio (taller cards)
              ),
              
              // PROPERTY 2: delegate
              // Provides the CHILDREN (album cards) for the grid
              // Uses builder for efficiency - only creates visible items
              delegate: SliverChildBuilderDelegate(
                // This function is called for each album in the list
                (BuildContext context, int index) {
                  final album = AlbumsData.afrobeatsAlbums[index];
                  return AlbumCard(
                    albumName: album.name,
                    artistName: album.artist,
                    color: album.color,
                  );
                },
                // PROPERTY 3: childCount
                // Total NUMBER of albums in the grid
                childCount: AlbumsData.afrobeatsAlbums.length,
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
}