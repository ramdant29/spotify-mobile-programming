import 'package:flutter/material.dart';

class FavoriteSongFeatureApp extends StatelessWidget {
  const FavoriteSongFeatureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FavoriteSongPage(),
    );
  }
}

class FavoriteSongPage extends StatefulWidget {
  const FavoriteSongPage({super.key});

  @override
  State<FavoriteSongPage> createState() => _FavoriteSongPageState();
}

class _FavoriteSongPageState extends State<FavoriteSongPage> {
  final List<SongItem> _songs = [
    const SongItem(
      title: 'Dandelions',
      artist: 'Ruth B.',
      subtitle: 'Playlist • 24 lagu',
      color: Color(0xFF1DB954),
    ),
    const SongItem(
      title: 'Levitating',
      artist: 'Dua Lipa',
      subtitle: 'Playlist • 18 lagu',
      color: Color(0xFF7C4DFF),
    ),
    const SongItem(
      title: 'Sunflower',
      artist: 'Post Malone',
      subtitle: 'Mood',
      color: Color(0xFFFF9800),
    ),
    const SongItem(
      title: 'Perfect',
      artist: 'Ed Sheeran',
      subtitle: 'Made for you',
      color: Color(0xFF00BCD4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final likedSongs = _songs.where((song) => song.isFavorite).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          title: const Text(
            'Lagu Favorit',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF1DB954),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: 'Pencarian'),
              Tab(text: 'Koleksi'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _SearchSongList(
              songs: _songs,
              onToggleFavorite: (song) {
                setState(() {
                  final index = _songs.indexOf(song);
                  if (index == -1) return;
                  _songs[index] = song.copyWith(isFavorite: !song.isFavorite);
                });
              },
            ),
            _CollectionSongList(songs: likedSongs),
          ],
        ),
      ),
    );
  }
}

class _SearchSongList extends StatelessWidget {
  const _SearchSongList({
    required this.songs,
    required this.onToggleFavorite,
  });

  final List<SongItem> songs;
  final void Function(SongItem song) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
      child: ListView.separated(
        itemCount: songs.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final song = songs[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 58,
                    height: 58,
                    color: song.color,
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        song.artist,
                        style: const TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => onToggleFavorite(song),
                  icon: Icon(
                    song.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: song.isFavorite ? Colors.red : Colors.white,
                    size: 26,
                  ),
                  splashRadius: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CollectionSongList extends StatelessWidget {
  const _CollectionSongList({required this.songs});

  final List<SongItem> songs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: songs.isEmpty
          ? const Center(
              child: Text(
                'Belum ada lagu yang disukai',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            )
          : ListView(
              children: [
                const Text(
                  'Lagu yang Anda Sukai',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                ...songs.map(
                  (song) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 58,
                            height: 58,
                            color: song.color,
                            child: const Icon(
                              Icons.music_note,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                song.artist,
                                style: const TextStyle(
                                  color: Color(0xFFB3B3B3),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class SongItem {
  const SongItem({
    required this.title,
    required this.artist,
    required this.subtitle,
    required this.color,
    this.isFavorite = false,
  });

  final String title;
  final String artist;
  final String subtitle;
  final Color color;
  final bool isFavorite;

  SongItem copyWith({bool? isFavorite}) {
    return SongItem(
      title: title,
      artist: artist,
      subtitle: subtitle,
      color: color,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

void main() {
  runApp(const FavoriteSongFeatureApp());
}

