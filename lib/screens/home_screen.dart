import 'package:flutter/material.dart';
import 'search_screen.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/category_grid.dart';
import '../widgets/playlist_section.dart';
import '../widgets/mini_player.dart';
import '../widgets/collection_menu.dart';
import 'settings_screen.dart';
import 'create_screen.dart';
import 'playlist_detail_screen.dart';
import 'recent_info_screen.dart';
import 'recent_player_screen.dart';
import '../utils/dummy_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _drawerSelectedIndex = 0;
  bool _isLoggedIn = false;

  final List<String> _pageTitles = const [
    'Home',
    'Cari',
    'Koleksi Kamu',
    'Buat',
  ];

  Route _detailRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 420),
      reverseTransitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetTween = Tween<Offset>(
          begin: const Offset(0, 0.06),
          end: Offset.zero,
        ).chain(
          CurveTween(curve: Curves.easeOutCubic),
        );

        return SlideTransition(
          position: animation.drive(offsetTween),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  void _openPlaylistDetail(Map<String, dynamic> playlist) {
    Navigator.push(
      context,
      _detailRoute(
        PlaylistDetailScreen(
          title: playlist['title'] as String,
          subtitle: playlist['subtitle'] as String,
          color: playlist['color'] as Color? ??
              const Color(0xFF1DB954),
        ),
      ),
    );
  }

  void _openRecentPlayer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RecentScreen(),
      ),
    );
  }

  void _openRecentInformation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RecentInformationScreen(),
      ),
    );
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsPage(
          isLoggedIn: _isLoggedIn,
          onLogout: _isLoggedIn ? _logout : null,
        ),
      ),
    );
  }

  List<Widget> get _pages => [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  'Made For You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              PlaylistSection(
                title: 'Made For You',
                playlists: madeForYouList,
                showTitle: false,
                onPlaylistTap: (index) {
                  _openPlaylistDetail(
                    madeForYouList[index],
                  );
                },
              ),
              const SizedBox(height: 24),
              CategoryGrid(
                categories: categoryList,
              ),
              const SizedBox(height: 24),
              PlaylistSection(
                title: 'Playlist Kamu',
                playlists: yourPlaylistList,
                onPlaylistTap: (index) {
                  _openPlaylistDetail(
                    yourPlaylistList[index],
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        const SearchPage(),
        const CollectionMenu(),
        const CreateScreen(),
      ];

  void _logout() {
    setState(() {
      _isLoggedIn = false;
    });

    Navigator.of(context).popUntil(
      (route) => route.isFirst,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Anda berhasil logout.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 28,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          _pageTitles[_selectedIndex],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        titleSpacing: 0,
      ),
      drawer: CustomDrawer(
        selectedIndex: _drawerSelectedIndex,
        isLoggedIn: _isLoggedIn,
        onDestinationSelected: (i) {
          setState(() {
            _drawerSelectedIndex = i;
          });

          Navigator.pop(context);

          if (i == 1) {
            _openRecentPlayer();
          }

          if (i == 2) {
            _openRecentInformation();
          }

          if (i == 3) {
            _openSettings();
          }
        },
      ),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
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
              selectedItemColor: const Color(0xFF1DB954),
              unselectedItemColor: const Color(0xffb3b3b3),
              type: BottomNavigationBarType.fixed,
              iconSize: 28,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 0,
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