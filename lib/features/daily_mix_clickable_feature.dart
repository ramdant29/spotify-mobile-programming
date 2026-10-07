import 'package:flutter/material.dart';

class DailyMixItem {
  const DailyMixItem({
    required this.title,
    required this.subtitle,
    required this.artist,
    required this.color,
  });

  final String title;
  final String subtitle;
  final String artist;
  final Color color;
}

class DailyMixClickablePage extends StatelessWidget {
  const DailyMixClickablePage({super.key});

  static const List<DailyMixItem> _items = [
    DailyMixItem(
      title: 'Daily Mix 1',
      subtitle: 'Playlist • 24 lagu',
      artist: 'Curated mix',
      color: Color(0xFF1DB954),
    ),
    DailyMixItem(
      title: 'Chill Hits',
      subtitle: 'Playlist • 18 lagu',
      artist: 'Slow and mellow',
      color: Color(0xFF7C4DFF),
    ),
    DailyMixItem(
      title: 'Night Drive',
      subtitle: 'Mood',
      artist: 'Midnight energy',
      color: Color(0xFFFF9800),
    ),
    DailyMixItem(
      title: 'Your Top Songs',
      subtitle: 'Made for you',
      artist: 'Playlist',
      color: Color(0xFF00BCD4),
    ),
    DailyMixItem(
      title: 'Indie Pop',
      subtitle: 'Baru',
      artist: 'Fresh sounds',
      color: Color(0xFFE91E63),
    ),
    DailyMixItem(
      title: 'Jazz Relax',
      subtitle: 'Akustik',
      artist: 'Smooth jazz',
      color: Color(0xFF795548),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          title: const Text(
            'Daily Mix',
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
            SearchMixList(items: _items),
            CollectionMixList(items: _items),
          ],
        ),
      ),
    );
  }
}

class SearchMixList extends StatefulWidget {
  const SearchMixList({super.key, required this.items});

  final List<DailyMixItem> items;

  @override
  State<SearchMixList> createState() => _SearchMixListState();
}

class _SearchMixListState extends State<SearchMixList> {
  final TextEditingController _controller = TextEditingController();

  List<DailyMixItem> get _filteredItems {
    final query = _controller.text.trim().toLowerCase();
    if (query.isEmpty) {
      return widget.items;
    }

    return widget.items.where((item) {
      final title = item.title.toLowerCase();
      final subtitle = item.subtitle.toLowerCase();
      final artist = item.artist.toLowerCase();
      return title.contains(query) ||
          subtitle.contains(query) ||
          artist.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredItems;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _controller,
              onChanged: (_) => setState(() {}),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                hintText: 'Apa yang ingin kamu dengarkan?',
                hintStyle: TextStyle(
                  color: Color(0xFF5F5F5F),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.black, size: 20),
                prefixIconConstraints: BoxConstraints(minWidth: 42),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 14),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada hasil yang cocok',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  )
                : ListView.separated(
                    itemCount: results.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = results[index];
                      return _ClickableMixRow(
                        item: item,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DailyMixDetailScreen(item: item),
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

class CollectionMixList extends StatelessWidget {
  const CollectionMixList({super.key, required this.items});

  final List<DailyMixItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: ListView(
        children: [
          const Row(
            children: [
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
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ClickableMixRow(
                item: item,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DailyMixDetailScreen(item: item),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClickableMixRow extends StatelessWidget {
  const _ClickableMixRow({required this.item, required this.onTap});

  final DailyMixItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
                color: item.color,
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
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
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
      ),
    );
  }
}

class DailyMixDetailScreen extends StatelessWidget {
  const DailyMixDetailScreen({super.key, required this.item});

  final DailyMixItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.music_note,
                color: Colors.white,
                size: 96,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.artist,
              style: const TextStyle(
                color: Color(0xFFB3B3B3),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Putar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1DB954),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


