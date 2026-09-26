import 'package:flutter/material.dart';
import 'search_screen.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/category_grid.dart';
import '../widgets/playlist_section.dart';
import '../widgets/mini_player.dart';
import '../utils/dummy_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _drawerSelectedIndex = 0;

  final List<String> _pageTitles = const [
    'Home',
    'Cari',
    'Koleksi Kamu',
    'Buat',
  ];

  List<Widget> get _pages => [
        SingleChildScrollView(
          child: Column(
            children: [
              CategoryGrid(categories: categoryList),
              const SizedBox(height: 24),
              PlaylistSection(
                title: 'Playlist Kamu',
                playlists: yourPlaylistList,
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