import 'package:flutter/material.dart';
import '/models/category_model.dart';

const List<CategoryModel> categoryList = [
  CategoryModel(name: 'Pop', icon: Icons.music_note),
  CategoryModel(name: 'Hip Hop', icon: Icons.music_note),
  CategoryModel(name: 'Jazz', icon: Icons.music_note),
  CategoryModel(name: 'Rock', icon: Icons.music_note),
  CategoryModel(name: 'K-Pop', icon: Icons.music_note),
  CategoryModel(name: 'Dangdut', icon: Icons.music_note),
  CategoryModel(name: 'Indie', icon: Icons.music_note),
  CategoryModel(name: 'R&B', icon: Icons.music_note),
];

const List<Map<String, dynamic>> yourPlaylistList = [
  {
    'title': 'Playlist 1',
    'subtitle': 'User',
    'color': Color.fromARGB(255, 41, 41, 41),
  },
  {
    'title': 'Playlist 2',
    'subtitle': 'User',
    'color': Color.fromARGB(255, 41, 41, 41),
  },
  {
    'title': 'Playlist 3',
    'subtitle': 'User',
    'color': Color.fromARGB(255, 41, 41, 41),
  },
  {
    'title': 'Playlist 4',
    'subtitle': 'User',
    'color': Color.fromARGB(255, 41, 41, 41),
  },
];