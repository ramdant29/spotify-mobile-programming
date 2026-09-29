import 'package:flutter/material.dart';

class CollectionMenu extends StatelessWidget {
  const CollectionMenu({super.key});

  static const List<String> _filters = [
    'Semua',
    'Playlist',
    'Podcast',
    'Album',
    'Artis',
  ];

  static const List<Map<String, dynamic>> _libraryItems = [
    {
      'title': 'Daily Mix 1',
      'subtitle': 'Playlist • 24 lagu',
      'color': Color(0xFF1DB954),
    },
    {
      'title': 'Chill Hits',
      'subtitle': 'Playlist • 18 lagu',
      'color': Color(0xFF7C4DFF),
    },
    {
      'title': 'Night Drive',
      'subtitle': 'Playlist • 31 lagu',
      'color': Color(0xFFFF9800),
    },
    {
      'title': 'The Weekend',
      'subtitle': 'Artis • 74 lagu',
      'color': Color(0xFFB39DDB),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final isSelected = index == 0;
                  return ChoiceChip(
                    label: Text(
                      _filters[index],
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (_) {},
                    selectedColor: Colors.white,
                    backgroundColor: const Color(0xFF2A2A2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: const [
                Icon(Icons.swap_vert, color: Colors.white70, size: 18),
                SizedBox(width: 8),
                Text(
                  'Urutkan',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._libraryItems.map((item) {
              final title = item['title'] as String;
              final subtitle = item['subtitle'] as String;
              final color = item['color'] as Color;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                        color: color,
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: Color(0xFFB3B3B3),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
