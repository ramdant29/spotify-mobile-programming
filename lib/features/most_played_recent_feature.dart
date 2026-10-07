import 'package:flutter/material.dart';

class MostPlayedRecentFeatureApp extends StatelessWidget {
  const MostPlayedRecentFeatureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MostPlayedRecentPage(),
    );
  }
}

class MostPlayedRecentPage extends StatelessWidget {
  const MostPlayedRecentPage({super.key});

  static const List<TrackItem> frequentlyPlayed = [
    TrackItem(
      title: 'Dandelions',
      artist: 'Ruth B.',
      count: '1.2k putaran',
      color: Color(0xFF1DB954),
    ),
    TrackItem(
      title: 'Levitating',
      artist: 'Dua Lipa',
      count: '980 putaran',
      color: Color(0xFF7C4DFF),
    ),
    TrackItem(
      title: 'Sunflower',
      artist: 'Post Malone',
      count: '860 putaran',
      color: Color(0xFFFF9800),
    ),
    TrackItem(
      title: 'Perfect',
      artist: 'Ed Sheeran',
      count: '740 putaran',
      color: Color(0xFF00BCD4),
    ),
  ];

  static const List<TrackItem> recentlyPlayed = [
    TrackItem(
      title: 'Night Changes',
      artist: 'One Direction',
      count: '2 jam lalu',
      color: Color(0xFFE91E63),
    ),
    TrackItem(
      title: 'The Nights',
      artist: 'Avicii',
      count: '5 jam lalu',
      color: Color(0xFF795548),
    ),
    TrackItem(
      title: 'Bad Guy',
      artist: 'Billie Eilish',
      count: '1 hari lalu',
      color: Color(0xFF607D8B),
    ),
    TrackItem(
      title: 'Lovely',
      artist: 'Billie Eilish',
      count: '2 hari lalu',
      color: Color(0xFF8BC34A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Riwayat Putar',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Paling sering diputar',
                subtitle: 'Lagu favoritmu yang paling sering diputar',
              ),
              const SizedBox(height: 12),
              ...frequentlyPlayed.map((item) => TrackListTile(track: item)),
              const SizedBox(height: 28),
              const SectionHeader(
                title: 'Paling baru diputar',
                subtitle: 'Lagu yang baru terakhir kamu dengarkan',
              ),
              const SizedBox(height: 12),
              ...recentlyPlayed.map((item) => TrackListTile(track: item)),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFFB3B3B3),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class TrackListTile extends StatelessWidget {
  const TrackListTile({
    super.key,
    required this.track,
  });

  final TrackItem track;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 56,
              height: 56,
              color: track.color,
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
                  track.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  track.artist,
                  style: const TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            track.count,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: 26,
          ),
        ],
      ),
    );
  }
}

class TrackItem {
  const TrackItem({
    required this.title,
    required this.artist,
    required this.count,
    required this.color,
  });

  final String title;
  final String artist;
  final String count;
  final Color color;
}

void main() {
  runApp(const MostPlayedRecentFeatureApp());
}
