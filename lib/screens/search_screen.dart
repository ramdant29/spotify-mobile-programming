import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _searchHistory = [];

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        if (!_searchHistory.contains(query)) {
          _searchHistory.insert(0, query);
        }
      });
      _controller.clear();
    }
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
    return Scaffold(
      backgroundColor: Colors.black, // background hitam
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Apa yang ingin kamu dengarkan?',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                fillColor: Colors.white, // tetap putih agar kontras
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: _onSearch,
            ),
            const SizedBox(height: 20),

            // Jika ada riwayat pencarian
            if (_searchHistory.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Riwayat Pencarian',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // teks putih
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _clearAllHistory,
                    icon: const Icon(Icons.delete_forever, color: Colors.red),
                    label: const Text(
                      'Hapus Semua',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchHistory.length,
                  itemBuilder: (context, index) {
                    final query = _searchHistory[index];
                    return ListTile(
                      leading: const Icon(Icons.history, color: Colors.white),
                      title: Text(
                        query,
                        style: const TextStyle(
                          color: Colors.white,
                        ), // teks putih
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => _removeHistory(index),
                      ),
                      onTap: () => _onSearch(query),
                    );
                  },
                ),
              ),
            ],

            // Jika riwayat kosong
            if (_searchHistory.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'Tidak ada riwayat pencarian',
                    style: const TextStyle(color: Colors.white), // teks putih
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
