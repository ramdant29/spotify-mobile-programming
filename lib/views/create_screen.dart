import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'Playlist',
        'icon': Icons.queue_music_rounded,
        'color': const Color(0xFF1DB954),
      },
      {
        'title': 'Album',
        'icon': Icons.album_rounded,
        'color': const Color(0xFFFF9800),
      },
      {
        'title': 'Podcast',
        'icon': Icons.podcasts_rounded,
        'color': const Color(0xFF8E24AA),
      },
      {
        'title': 'Koleksi',
        'icon': Icons.favorite_rounded,
        'color': const Color(0xFF00BCD4),
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Buat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.05,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                final title = item['title'] as String;
                final icon = item['icon'] as IconData;
                final color = item['color'] as Color;

                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
