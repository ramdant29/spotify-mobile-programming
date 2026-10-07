import 'package:flutter/material.dart';
import 'package:spotify/widgets/music_player.dart';
import 'package:spotify/models/song_notifier.dart';

class MiniPlayer extends StatefulWidget {
  final String? title;
  final String? artist;

  const MiniPlayer({
    super.key,
    this.title,
    this.artist,
  });

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer>
    with TickerProviderStateMixin {
  bool _isPlaying = false;
  bool _isFavorite = false;
  
  late final AnimationController _barsController;
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    _barsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 3),
    );

    SongNotifier.currentTrack.addListener(_onSongChanged);

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        SongNotifier.nextTrack();
      }
    });
  }

  void _onSongChanged() {
    setState(() {
      _isPlaying = true;
    });

    _barsController.repeat();
    _progressController.reset();
    _progressController.forward();
  }

  @override
  void dispose() {
    SongNotifier.currentTrack.removeListener(_onSongChanged);
    _barsController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _openMusicPlayer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SpotifyNowPlayingWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bars = List.generate(4, (index) {
      final base = 10 + (index + 1) * 8;
      return AnimatedBuilder(
        animation: _barsController,
        builder: (context, child) {
          final value = _isPlaying
              ? 0.28 + ((index + 1) * 0.18) + (_barsController.value * 0.6)
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

    return ValueListenableBuilder<Map<String, String>>(
      valueListenable: SongNotifier.currentTrack,
      builder: (context, currentSong, child) {
        final displayTitle = widget.title ?? currentSong['title'] ?? 'Judul Lagu';
        final displayArtist = widget.artist ?? currentSong['artist'] ?? 'Nama Artis';

        return GestureDetector(
          onTap: _openMusicPlayer,
          child: Container(
            height: 72,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xff282828),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: _progressController.value,
                          minHeight: 2.5,
                          backgroundColor: Colors.white12,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF1DB954),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF1DB954),
                                Color(0xFF0F7A3B),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.music_note,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayTitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                displayArtist,
                                style: const TextStyle(
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
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite
                                ? const Color(0xFF1DB954)
                                : Colors.white,
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
                          onPressed: _openMusicPlayer,
                          icon: const Icon(
                            Icons.queue_music_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            _isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPlaying = !_isPlaying;

                              if (_isPlaying) {
                                _barsController.repeat();
                                _progressController.forward();
                              } else {
                                _barsController.stop();
                                _progressController.stop();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}