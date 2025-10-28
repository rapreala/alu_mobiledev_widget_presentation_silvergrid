import 'package:flutter/material.dart';

/// Album model
/// Represents a single album with its metadata
class Album {
  final String name;
  final String artist;
  final Color color;

  const Album({
    required this.name,
    required this.artist,
    required this.color,
  });
}

/// Afrobeats albums database
/// Contains popular Afrobeats albums with their artists and theme colors
class AlbumsData {
  static final List<Album> afrobeatsAlbums = [
    const Album(
      name: 'Made in Lagos',
      artist: 'Wizkid',
      color: Color(0xFFE74C3C),
    ),
    const Album(
      name: 'African Giant',
      artist: 'Burna Boy',
      color: Color(0xFF3498DB),
    ),
    const Album(
      name: 'A Better Time',
      artist: 'Davido',
      color: Color(0xFF9B59B6),
    ),
    const Album(
      name: 'Love, Damini',
      artist: 'Burna Boy',
      color: Color(0xFFE67E22),
    ),
    const Album(
      name: 'More Love Less Ego',
      artist: 'Wizkid',
      color: Color(0xFF1ABC9C),
    ),
    const Album(
      name: 'Timeless',
      artist: 'Davido',
      color: Color(0xFFF39C12),
    ),
    const Album(
      name: 'Boy Alone',
      artist: 'Omah Lay',
      color: Color(0xFF8E44AD),
    ),
    const Album(
      name: 'Playboy',
      artist: 'Fireboy DML',
      color: Color(0xFFE74C3C),
    ),
    const Album(
      name: '19 & Dangerous',
      artist: 'Ayra Starr',
      color: Color(0xFFEC407A),
    ),
    const Album(
      name: 'Rave & Roses',
      artist: 'Rema',
      color: Color(0xFF2ECC71),
    ),
    const Album(
      name: 'Mr Money With The Vibe',
      artist: 'Asake',
      color: Color(0xFFFF5722),
    ),
    const Album(
      name: 'The Year I Turned 21',
      artist: 'Ayra Starr',
      color: Color(0xFF9C27B0),
    ),
    const Album(
      name: 'Work of Art',
      artist: 'Asake',
      color: Color(0xFFFFC107),
    ),
    const Album(
      name: 'Twice as Tall',
      artist: 'Burna Boy',
      color: Color(0xFF00BCD4),
    ),
    const Album(
      name: 'Colours and Sounds',
      artist: 'Tems',
      color: Color(0xFF673AB7),
    ),
    const Album(
      name: 'Apollo',
      artist: 'Fireboy DML',
      color: Color(0xFFFF6F00),
    ),
  ];
}