import 'package:flutter/material.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  final List<Map<String, String>> songs = const [
    {
      'title': 'Sunset Lover',
      'artist': 'Petit Biscuit',
      'duration': '3:23',
    },
    {
      'title': 'Midnight City',
      'artist': 'M83',
      'duration': '4:00',
    },
    {
      'title': 'Dreams',
      'artist': 'The Cranberries',
      'duration': '4:32',
    },
    {
      'title': 'Electric Feel',
      'artist': 'MGMT',
      'duration': '3:49',
    },
    {
      'title': 'Good Life',
      'artist': 'OneRepublic',
      'duration': '4:13',
    },
    {
      'title': 'Levitating',
      'artist': 'Dua Lipa',
      'duration': '3:23',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
          ),
        ),
        title: const Text(
          'Baru Diputar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 24),
        itemCount: songs.length,
        separatorBuilder: (context, index) {
          return const Divider(
            color: Color(0xFF303030),
            height: 1,
            indent: 64,
          );
        },
        itemBuilder: (context, index) {
          final song = songs[index];

          return InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 2,
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF281D49),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song['title']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          song['artist']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFFA7A7A7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 40,
                    child: Text(
                      song['duration']!,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                        color: Color(0xFFA7A7A7),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 40,
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}