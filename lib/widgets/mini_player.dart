import 'package:flutter/material.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = true;
  bool _isFavorite = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bars = List.generate(4, (index) {
      final base = 10 + (index + 1) * 8;
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final value = _isPlaying
              ? 0.28 + ((index + 1) * 0.18) + (_controller.value * 0.6)
              : 0.18;
          return Container(
            width: 4,
            height: base * value,
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            decoration: BoxDecoration(
              color: _isPlaying ? Colors.green : Colors.white54,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      );
    });

    return Container(
      height: 72,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xff282828),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1DB954), Color(0xFF0F7A3B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.music_note, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Judul Lagu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Nama Artis',
                  style: TextStyle(
                    color: Color(0xffa7a7a7),
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() => _isFavorite = !_isFavorite);
            },
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? const Color(0xFF1DB954) : Colors.white,
              size: 20,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Row(
              key: ValueKey(_isPlaying),
              mainAxisAlignment: MainAxisAlignment.center,
              children: bars,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.queue_music_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
          ),
        ],
      ),
    );
  }
}
