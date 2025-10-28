import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Individual album card widget
/// Displays a single album with cover art, title, and artist name
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
        // Album cover art (simulated with gradient container)
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              // Gradient background simulating album art
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color.withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.album,
                size: 64,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        
        // Album name
        Text(
          albumName,
          style: const TextStyle(
            color: AppColors.primaryText,
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
            color: AppColors.secondaryText,
            fontSize: 13,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}