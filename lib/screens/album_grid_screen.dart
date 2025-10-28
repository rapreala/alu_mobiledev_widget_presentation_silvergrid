import 'package:flutter/material.dart';
import '../data/albums_data.dart';
import '../widgets/album_card.dart';
import '../constants/app_colors.dart';

/// Main screen displaying Afrobeats albums using SliverGrid
/// Demonstrates the three key properties of SliverGrid widget
/// Now with search, filter, and favorite functionality
class AlbumGridScreen extends StatefulWidget {
  const AlbumGridScreen({super.key});

  @override
  State<AlbumGridScreen> createState() => _AlbumGridScreenState();
}

class _AlbumGridScreenState extends State<AlbumGridScreen> {
  // Search query
  String _searchQuery = '';
  
  // Favorites list (track which albums are favorited)
  final Set<String> _favorites = {};
  
  // Selected genre filter
  String _selectedGenre = 'All';
  
  // Get unique genres from albums
  List<String> get _genres {
    final genres = AlbumsData.afrobeatsAlbums
        .map((album) => album.genre)
        .toSet()
        .toList();
    genres.insert(0, 'All');
    return genres;
  }
  
  // Filter albums based on search and genre
  List<Album> get _filteredAlbums {
    return AlbumsData.afrobeatsAlbums.where((album) {
      // Search filter
      final matchesSearch = album.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          album.artist.toLowerCase().contains(_searchQuery.toLowerCase());
      
      // Genre filter
      final matchesGenre = _selectedGenre == 'All' || album.genre == _selectedGenre;
      
      return matchesSearch && matchesGenre;
    }).map((album) {
      // Add favorite status
      return album.copyWith(isFavorite: _favorites.contains(album.name));
    }).toList();
  }

  /// Handle album tap - simulate playing album
  void _playAlbum(Album album) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Row(
          children: [
            Icon(
              Icons.play_circle_filled,
              color: AppColors.spotifyGreen,
              size: 32,
            ),
            const SizedBox(width: 12),
            const Text(
              'Now Playing',
              style: TextStyle(color: AppColors.primaryText),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              album.name,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'by ${album.artist}',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${album.releaseYear} • ${album.genre}',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: AppColors.spotifyGreen),
            ),
          ),
        ],
      ),
    );
  }

  /// Toggle favorite status
  void _toggleFavorite(Album album) {
    setState(() {
      if (_favorites.contains(album.name)) {
        _favorites.remove(album.name);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Removed ${album.name} from favorites'),
            duration: const Duration(seconds: 1),
            backgroundColor: AppColors.cardBackground,
          ),
        );
      } else {
        _favorites.add(album.name);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${album.name} to favorites ❤️'),
            duration: const Duration(seconds: 1),
            backgroundColor: AppColors.cardBackground,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredAlbums = _filteredAlbums;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Spotify-style app bar
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.darkBackground,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  const Text(
                    'Afrobeats Albums',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (_favorites.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_favorites.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              centerTitle: false,
            ),
          ),
          
          // Search bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: const TextStyle(color: AppColors.primaryText),
                decoration: InputDecoration(
                  hintText: 'Search albums or artists...',
                  hintStyle: TextStyle(color: AppColors.secondaryText),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.secondaryText,
                  ),
                  filled: true,
                  fillColor: AppColors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          
          // Genre filter chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _genres.length,
                itemBuilder: (context, index) {
                  final genre = _genres[index];
                  final isSelected = genre == _selectedGenre;
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(genre),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedGenre = genre;
                        });
                      },
                      backgroundColor: AppColors.cardBackground,
                      selectedColor: AppColors.spotifyGreen,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.secondaryText,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Results count
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '${filteredAlbums.length} album${filteredAlbums.length != 1 ? 's' : ''}',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          
          // ========================================
          // MAIN WIDGET: SliverGrid
          // ========================================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: filteredAlbums.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: AppColors.secondaryText,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No albums found',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SliverGrid(
                    // PROPERTY 1: gridDelegate
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 0.75,
                    ),
                    
                    // PROPERTY 2: delegate
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final album = filteredAlbums[index];
                        return AlbumCard(
                          albumName: album.name,
                          artistName: album.artist,
                          color: album.color,
                          releaseYear: album.releaseYear,
                          genre: album.genre,
                          isFavorite: album.isFavorite,
                          onTap: () => _playAlbum(album),
                          onFavoriteToggle: () => _toggleFavorite(album),
                        );
                      },
                      // PROPERTY 3: childCount
                      childCount: filteredAlbums.length,
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