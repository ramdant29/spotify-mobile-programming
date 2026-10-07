import 'package:flutter/material.dart';

class SpotifyNowPlayingWidget extends StatefulWidget {
  const SpotifyNowPlayingWidget({super.key});

  @override
  State<SpotifyNowPlayingWidget> createState() =>
      _SpotifyNowPlayingWidgetState();
}

class _SpotifyNowPlayingWidgetState
    extends State<SpotifyNowPlayingWidget> {
  bool isPlaying = false;
  bool isShuffleOn = false;
  double progress = 0.0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF542523),
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
              Color(0xFF874039),
              Color(0xFF6D2F2B),
              Color(0xFF542523),
            ],
            stops: [
              0.0,
              0.48,
              1.0,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final artworkSize =
                  (width - 48).clamp(0.0, 520.0);

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  24,
                  42,
                  24,
                  28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: SizedBox(
                        width: artworkSize,
                        height: artworkSize,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD15D55),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 29,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showMessage('Add to library');
                          },
                          icon: const Icon(
                            Icons.add_circle_outline_rounded,
                            color: Colors.white,
                            size: 29,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white30,
                        thumbColor: Colors.white,
                        overlayColor:
                            Colors.white.withValues(alpha: 0.12),
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
                        value: progress,
                        min: 0,
                        max: 1,
                        onChanged: (value) {
                          setState(() {
                            progress = value;
                          });
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '0:00',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '-0:00',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isShuffleOn = !isShuffleOn;
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
                            Icons.skip_previous_rounded,
                            color: Colors.white,
                            size: 43,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                          child: Container(
                            width: 68,
                            height: 68,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: const Color(0xFF542523),
                              size: 39,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showMessage('Next');
                          },
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            color: Colors.white,
                            size: 43,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showMessage('Timer');
                          },
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
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                showMessage('Devices');
                              },
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.devices_other_outlined,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
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
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                showMessage('Queue');
                              },
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.queue_music_rounded,
                                color: Colors.white,
                                size: 27,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                        18,
                        17,
                        18,
                        19,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B4039)
                            .withValues(alpha: 0.72),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Release countdown',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}