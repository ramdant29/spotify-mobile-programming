import 'package:flutter/material.dart';
import 'package:spotify/screens/search_screen.dart';
import 'package:spotify/widgets/drawer_menu.dart';
import 'package:spotify/widgets/category_grid.dart';
import 'package:spotify/widgets/playlist_section.dart';
import 'package:spotify/widgets/mini_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _drawerSelectedIndex = 0;

  List<String> get _pageTitles => [
        'Home',
        'Cari',
        'Koleksi Kamu',
        'Buat',
      ];

  List<Widget> get _pages => [
        SingleChildScrollView(
          child: Column(
            children: [
              CategoryGrid(categories: _categories),
              const SizedBox(height: 24),
              PlaylistSection(
                title: 'Playlist Kamu', 
                playlists: _yourPlaylist,
              ),
            ],
          ),
        ),
        const SearchPage(),
        const SizedBox(),
        const SizedBox(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        title: Text(
          _pageTitles[_selectedIndex],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff121212),
        foregroundColor: const Color(0xffffffff),
        elevation: 0,
      ),
      drawer: CustomDrawer(
        selectedIndex: _drawerSelectedIndex,
        onDestinationSelected: (i) {
          setState(() => _drawerSelectedIndex = i);
          Navigator.pop(context);
        },
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniPlayer(),
          Theme(
            data: Theme.of(context).copyWith(
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            child: BottomNavigationBar(
              backgroundColor: const Color(0xff121212),
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xffffffff),
              unselectedItemColor: const Color(0xff757575),
              type: BottomNavigationBarType.fixed,
              iconSize: 30,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: _navBarItems,
            ),
          ),
        ],
      ),
    );
  }
}

const _categories = [
  {'name': 'Pop', 'icon': Icons.music_note},
  {'name': 'Hip Hop', 'icon': Icons.music_note},
  {'name': 'Jazz', 'icon': Icons.music_note},
  {'name': 'Rock', 'icon': Icons.music_note},
  {'name': 'K-Pop', 'icon': Icons.music_note},
  {'name': 'Dangdut', 'icon': Icons.music_note},
  {'name': 'Indie', 'icon': Icons.music_note},
  {'name': 'R&B', 'icon': Icons.music_note},
];

const _yourPlaylist = [
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
  }
];

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search),
    activeIcon: Icon(Icons.search),
    label: 'Cari',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.library_music_outlined),
    activeIcon: Icon(Icons.library_music),
    label: 'Koleksi Kamu',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.add_outlined),
    activeIcon: Icon(Icons.add),
    label: 'Buat',
  ),
];
