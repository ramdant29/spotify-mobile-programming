import 'package:flutter/material.dart';

import 'song_detail_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _searchHistory = [];

  final List<String> _quickFilters = const [
    'Semua',
    'Podcast',
    'Album',
    'Artis',
    'Playlist',
  ];

  final List<Map<String, dynamic>> _allResults = const [
    {
      'title': 'Daily Mix 1',
      'subtitle': 'Playlist • 24 lagu',
      'artist': 'Curated mix',
      'color': Color(0xFF1DB954),
    },
    {
      'title': 'Chill Hits',
      'subtitle': 'Playlist • 18 lagu',
      'artist': 'Slow and mellow',
      'color': Color(0xFF7C4DFF),
    },
    {
      'title': 'Night Drive',
      'subtitle': 'Mood',
      'artist': 'Midnight energy',
      'color': Color(0xFFFF9800),
    },
    {
      'title': 'Your Top Songs',
      'subtitle': 'Made for you',
      'artist': 'Playlist',
      'color': Color(0xFF00BCD4),
    },
    {
      'title': 'Indie Pop',
      'subtitle': 'Baru',
      'artist': 'Fresh sounds',
      'color': Color(0xFFE91E63),
    },
    {
      'title': 'Jazz Relax',
      'subtitle': 'Akustik',
      'artist': 'Smooth jazz',
      'color': Color(0xFF795548),
    },
    {
      'title': 'Sunset Lover',
      'subtitle': 'Lagu • 3:23',
      'artist': 'Petit Biscuit',
      'color': Color(0xFF8BC34A),
    },
    {
      'title': 'Midnight City',
      'subtitle': 'Lagu • 3:44',
      'artist': 'M83',
      'color': Color(0xFF607D8B),
    },
  ];

  List<Map<String, dynamic>> get _filteredResults {
    final query = _controller.text.trim().toLowerCase();
    if (query.isEmpty) {
      return _allResults;
    }

    return _allResults.where((item) {
      final title = (item['title'] as String).toLowerCase();
      final subtitle = (item['subtitle'] as String).toLowerCase();
      return title.contains(query) || subtitle.contains(query);
    }).toList();
  }

  Route _detailRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 420),
      reverseTransitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetTween = Tween<Offset>(
          begin: const Offset(0, 0.06),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));

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

  void _onSearch(String query) {
    final cleanedQuery = query.trim();
    if (cleanedQuery.isEmpty) return;

    setState(() {
      if (!_searchHistory.contains(cleanedQuery)) {
        _searchHistory.insert(0, cleanedQuery);
      }
    });
  }

  void _removeHistory(int index) {
    setState(() {
      _searchHistory.removeAt(index);
    });
  }

  void _clearAllHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasQuery = _controller.text.trim().isNotEmpty;
    final results = _filteredResults;

    return Material(
      color: const Color(0xFF121212),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                onChanged: (_) => setState(() {}),
                onSubmitted: _onSearch,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Apa yang ingin kamu dengarkan?',
                  hintStyle: const TextStyle(
                    color: Color(0xFF5F5F5F),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            if (hasQuery) ...[
              const Text(
                'Hasil Pencarian',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: results.isEmpty
                    ? const Center(
                        child: Text(
                          'Tidak ada hasil yang cocok',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: results.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = results[index];
                          final title = item['title'] as String;
                          final subtitle = item['subtitle'] as String;
                          final artist = item['artist'] as String;
                          final color = item['color'] as Color;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                _detailRoute(
                                  SongDetailScreen(
                                    title: title,
                                    artist: artist,
                                    color: color,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1D1D1D),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.music_note,
                                      color: Colors.white,
                                      size: 26,
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
                                            color: Color(0xFFB4B4B4),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ] else ...[
              if (_searchHistory.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Riwayat Pencarian',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: _clearAllHistory,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Hapus Semua',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    itemCount: _searchHistory.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 0),
                    itemBuilder: (context, index) {
                      final query = _searchHistory[index];
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.history,
                          color: Colors.white70,
                        ),
                        title: Text(
                          query,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white70,
                            size: 20,
                          ),
                          onPressed: () => _removeHistory(index),
                        ),
                        onTap: () => _onSearch(query),
                      );
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cari untukmu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 38,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _quickFilters.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final isSelected = index == 0;
                              return ChoiceChip(
                                label: Text(
                                  _quickFilters[index],
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
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Rekomendasi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _allResults.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.25,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemBuilder: (context, index) {
                            final item = _allResults[index];
                            final color = item['color'] as Color;
                            final title = item['title'] as String;
                            final subtitle = item['subtitle'] as String;

                            return Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E1E1E),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(14),
                                          topRight: Radius.circular(14),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.music_note,
                                          color: Colors.white,
                                          size: 34,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          subtitle,
                                          style: const TextStyle(
                                            color: Color(0xFFB5B5B5),
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
