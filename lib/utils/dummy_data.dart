import 'package:flutter/material.dart';
import '/models/category_model.dart';

const List<CategoryModel> categoryList = [
  CategoryModel(name: 'Pop', icon: Icons.music_note_rounded),
  CategoryModel(name: 'Hip Hop', icon: Icons.headphones_rounded),
  CategoryModel(name: 'Jazz', icon: Icons.earbuds_rounded),
  CategoryModel(name: 'Rock', icon: Icons.speaker_rounded),
  CategoryModel(name: 'K-Pop', icon: Icons.microwave_rounded),
  CategoryModel(name: 'Dangdut', icon: Icons.piano_rounded),
  CategoryModel(name: 'Indie', icon: Icons.graphic_eq_rounded),
  CategoryModel(name: 'R&B', icon: Icons.queue_music_rounded),
];

const List<Map<String, dynamic>> madeForYouList = [
  {
    'title': 'Daily Mix 1',
    'subtitle': 'Your favorite songs',
    'color': Color(0xFF1DB954),
  },
  {
    'title': 'Chill Hits',
    'subtitle': 'Slow and mellow',
    'color': Color(0xFF7C4DFF),
  },
  {
    'title': 'Night Drive',
    'subtitle': 'Midnight energy',
    'color': Color(0xFFFF9800),
  },
  {
    'title': 'Focus Flow',
    'subtitle': 'Deep work vibes',
    'color': Color(0xFF00BCD4),
  },
];

const List<Map<String, dynamic>> yourPlaylistList = [
  {
    'title': 'Playlist 1',
    'subtitle': 'User',
    'color': Color(0xFF2A2A2A),
  },
  {
    'title': 'Playlist 2',
    'subtitle': 'User',
    'color': Color(0xFF3A3A3A),
  },
  {
    'title': 'Playlist 3',
    'subtitle': 'User',
    'color': Color(0xFF2F2F2F),
  },
  {
    'title': 'Playlist 4',
    'subtitle': 'User',
    'color': Color(0xFF404040),
  },
];