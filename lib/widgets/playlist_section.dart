import 'package:flutter/material.dart';

class PlaylistSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> playlists;

  const PlaylistSection({
    super.key,
    required this.title,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 165,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return Container(
                width: 165,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 165,
                      height: 140,
                      decoration: BoxDecoration(
                        color: playlist['color'] as Color? ?? Colors.grey[900],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      playlist['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}