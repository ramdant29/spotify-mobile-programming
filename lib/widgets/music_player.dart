import 'package:flutter/material.dart';
import 'package:spotify/models/song_notifier.dart';

final ValueNotifier<bool> globalIsPlaying =
    ValueNotifier<bool>(false);

final ValueNotifier<double> globalProgress =
    ValueNotifier<double>(0.0);

final ValueNotifier<double> globalTotalSeconds =
    ValueNotifier<double>(180.0);

const Map<String, double> fallbackDurations = {
  'Sunset Lover': 203.0,
  'Midnight City': 240.0,
  'Dreams': 272.0,
  'Electric Feel': 229.0,
  'Good Life': 253.0,
  'Levitating': 203.0,
};

double getTrackDurationSeconds(Map<String, String> song) {
  final duration = song['duration'];

  if (duration != null && duration.isNotEmpty) {
    final parts = duration.split(':');

    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]);
      final seconds = int.tryParse(parts[1]);

      if (minutes != null && seconds != null) {
        return (minutes * 60 + seconds).toDouble();
      }
    }
  }

  final title = song['title'];

  if (title != null && fallbackDurations.containsKey(title)) {
    return fallbackDurations[title]!;
  }

  return 180.0;
}

String formatDuration(double seconds) {
  final duration = Duration(
    seconds: seconds.round(),
  );

  final minutes = duration.inMinutes;
  final remainingSeconds = duration.inSeconds % 60;

  return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
}

class SpotifyNowPlayingWidget extends StatefulWidget {
  const SpotifyNowPlayingWidget({super.key});

  @override
  State<SpotifyNowPlayingWidget> createState() =>
      _SpotifyNowPlayingWidgetState();
}

class _SpotifyNowPlayingWidgetState
    extends State<SpotifyNowPlayingWidget> {
  bool isShuffleOn = false;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    final currentSong = SongNotifier.currentTrack.value;
    final duration = getTrackDurationSeconds(currentSong);

    globalTotalSeconds.value = duration;
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 900),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void showTimer() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF282828),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sleep Timer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(
                    Icons.timer_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '5 menit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showMessage('Timer 5 menit');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.timer_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '10 menit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showMessage('Timer 10 menit');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.timer_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '30 menit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showMessage('Timer 30 menit');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.timer_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Akhir lagu',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showMessage('Timer sampai akhir lagu');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDevices() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF282828),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Connect to a device',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(
                    Icons.smartphone_rounded,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'This device',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showMessage('This device dipilih');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.computer_rounded,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Computer',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showMessage('Computer dipilih');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showQueue() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF181818),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.62,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 12, 12),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Queue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.queue_music_rounded,
                          color: Colors.white24,
                          size: 64,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Queue masih kosong',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Tambahkan lagu untuk melihat antrean.',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 31,
          ),
        ),
        title: const Text(
          'NOW PLAYING',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showMessage('More options');
            },
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A2A2A),
              Color(0xFF121212),
              Color(0xFF121212),
            ],
            stops: [
              0.0,
              0.5,
              1.0,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final artworkSize =
                  (constraints.maxWidth - 48).clamp(0.0, 520.0);

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  24,
                  42,
                  24,
                  28,
                ),
                child: ValueListenableBuilder<Map<String, String>>(
                  valueListenable: SongNotifier.currentTrack,
                  builder: (context, song, child) {
                    final title =
                        song['title'] ?? 'Judul Lagu';

                    final artist =
                        song['artist'] ?? 'Nama Artis';

                    return Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: SizedBox(
                            width: artworkSize,
                            height: artworkSize,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1DB954),
                                borderRadius:
                                    BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.music_note_rounded,
                                color: Colors.white,
                                size: 100,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    maxLines: 1,
                                    overflow:
                                        TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    artist,
                                    maxLines: 1,
                                    overflow:
                                        TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isLiked = !isLiked;
                                });
                              },
                              icon: Icon(
                                isLiked
                                    ? Icons.favorite_rounded
                                    : Icons
                                        .favorite_border_rounded,
                                color: isLiked
                                    ? const Color(0xFF1DB954)
                                    : Colors.white,
                                size: 29,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ValueListenableBuilder<double>(
                          valueListenable: globalProgress,
                          builder:
                              (context, progress, child) {
                            return SliderTheme(
                              data: SliderTheme.of(context)
                                  .copyWith(
                                trackHeight: 3,
                                activeTrackColor:
                                    Colors.white,
                                inactiveTrackColor:
                                    Colors.white30,
                                thumbColor: Colors.white,
                                overlayColor: Colors.white
                                    .withValues(alpha: 0.12),
                                thumbShape:
                                    const RoundSliderThumbShape(
                                  enabledThumbRadius: 5,
                                ),
                                overlayShape:
                                    const RoundSliderOverlayShape(
                                  overlayRadius: 13,
                                ),
                              ),
                              child: Slider(
                                value: progress
                                    .clamp(0.0, 1.0),
                                min: 0,
                                max: 1,
                                onChanged: (value) {
                                  globalProgress
                                      .value = value;
                                },
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder<double>(
                          valueListenable: globalProgress,
                          builder:
                              (context, progress, child) {
                            return ValueListenableBuilder<double>(
                              valueListenable:
                                  globalTotalSeconds,
                              builder: (
                                context,
                                totalSeconds,
                                child,
                              ) {
                                final currentSeconds =
                                    totalSeconds *
                                        progress;

                                final remainingSeconds =
                                    totalSeconds -
                                        currentSeconds;

                                return Padding(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Text(
                                        formatDuration(
                                          currentSeconds,
                                        ),
                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.white70,
                                          fontSize: 11,
                                          fontWeight:
                                              FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '-${formatDuration(remainingSeconds)}',
                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.white70,
                                          fontSize: 11,
                                          fontWeight:
                                              FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isShuffleOn =
                                      !isShuffleOn;
                                });
                              },
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.shuffle_rounded,
                                color: isShuffleOn
                                    ? const Color(0xFF1ED760)
                                    : Colors.white,
                                size: 28,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showMessage('Previous');
                              },
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons
                                    .skip_previous_rounded,
                                color: Colors.white,
                                size: 43,
                              ),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable:
                                  globalIsPlaying,
                              builder: (
                                context,
                                isPlaying,
                                child,
                              ) {
                                return GestureDetector(
                                  onTap: () {
                                    globalIsPlaying.value =
                                        !globalIsPlaying
                                            .value;
                                  },
                                  child: Container(
                                    width: 68,
                                    height: 68,
                                    decoration:
                                        const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isPlaying
                                          ? Icons
                                              .pause_rounded
                                          : Icons
                                              .play_arrow_rounded,
                                      color: const Color(
                                          0xFF121212),
                                      size: 39,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                SongNotifier.nextTrack();
                              },
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                color: Colors.white,
                                size: 43,
                              ),
                            ),
                            IconButton(
                              onPressed: showTimer,
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.timer_outlined,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment:
                                    Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: showDevices,
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons
                                        .devices_other_outlined,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment:
                                    Alignment.center,
                                child: IconButton(
                                  onPressed: () {
                                    showMessage('Share');
                                  },
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.share_outlined,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment:
                                    Alignment.centerRight,
                                child: IconButton(
                                  onPressed: showQueue,
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons
                                        .queue_music_rounded,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}