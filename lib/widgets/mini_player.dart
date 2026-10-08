import 'dart:math' as math;
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
      duration: Duration(
        milliseconds: (initialDuration * 1000).round(),
      ),
      value: globalProgress.value,
    );

    SongNotifier.currentTrack.addListener(_onSongChanged);
    globalIsPlaying.addListener(_onPlayingChanged);
    globalProgress.addListener(_onGlobalProgressChanged);

    _progressController.addListener(_syncProgress);

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        SongNotifier.nextTrack();
      }
    });

    _onPlayingChanged();
  }

  void _onSongChanged() {
    final currentSong = SongNotifier.currentTrack.value;
    final duration = getTrackDurationSeconds(currentSong);

    globalTotalSeconds.value = duration;
    globalProgress.value = 0.0;
    globalIsPlaying.value = true;

    _progressController.duration = Duration(
      milliseconds: (duration * 1000).round(),
    );

    _progressController
      ..reset()
      ..forward();

    if (!_barsController.isAnimating) {
      _barsController.repeat();
    }
  }

  void _onPlayingChanged() {
    if (globalIsPlaying.value) {
      if (!_barsController.isAnimating) {
        _barsController.repeat();
      }

      if (!_progressController.isAnimating &&
          _progressController.value < 1.0) {
        _progressController.forward();
      }
    } else {
      _barsController.stop();
      _progressController.stop();
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _syncProgress() {
    final value = _progressController.value;

    if ((globalProgress.value - value).abs() > 0.001) {
      globalProgress.value = value;
    }
  }

  void _onGlobalProgressChanged() {
    final value = globalProgress.value.clamp(0.0, 1.0);

    if ((_progressController.value - value).abs() > 0.001) {
      _progressController.value = value;
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _openMusicPlayer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const SpotifyNowPlayingWidget(),
      ),
    );
  }

  @override
  void dispose() {
    SongNotifier.currentTrack.removeListener(
      _onSongChanged,
    );

    globalIsPlaying.removeListener(
      _onPlayingChanged,
    );

    globalProgress.removeListener(
      _onGlobalProgressChanged,
    );

    _progressController.removeListener(
      _syncProgress,
    );

    _barsController.dispose();
    _progressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bars = List.generate(4, (index) {
      return AnimatedBuilder(
        animation: _barsController,
        builder: (context, child) {
          final progress = (_barsController.value + (index * 0.25)) % 1.0;
          final scale = _isPlaying
              ? 0.3 + 0.7 * (0.5 + 0.5 * math.sin(progress * 2 * math.pi))
              : 0.2;

          return Container(
            width: 3.5,
            height: 18,
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 80),
              width: 3.5,
              height: 18 * scale,
              decoration: BoxDecoration(
                color: _isPlaying ? const Color(0xFF1DB954) : Colors.white38,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        },
      );
    });

    return ValueListenableBuilder<Map<String, String>>(
      valueListenable: SongNotifier.currentTrack,
      builder: (context, currentSong, child) {
        final displayTitle =
            widget.title ??
            currentSong['title'] ??
            'Judul Lagu';

        final displayArtist =
            widget.artist ??
            currentSong['artist'] ??
            'Nama Artis';

        return GestureDetector(
          onTap: _openMusicPlayer,
          child: Container(
            height: 72,
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
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
                    child: ValueListenableBuilder<double>(
                      valueListenable: globalProgress,
                      builder: (
                        context,
                        progress,
                        child,
                      ) {
                        return LinearProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          minHeight: 2.5,
                          backgroundColor: Colors.white12,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(
                            Color(0xFF1DB954),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
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
                            borderRadius:
                                BorderRadius.circular(8),
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
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayTitle,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                displayArtist,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xffa7a7a7),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isFavorite =
                                  !_isFavorite;
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
                          duration:
                              const Duration(
                            milliseconds: 250,
                          ),
                          child: Row(
                            key: ValueKey(
                              globalIsPlaying.value,
                            ),
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: bars,
                          ),
                        ),
                        IconButton(
                          onPressed:
                              _openMusicPlayer,
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