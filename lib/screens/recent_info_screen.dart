import 'package:flutter/material.dart';

class RecentInformationScreen extends StatelessWidget {
  const RecentInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 30,
          ),
        ),
        title: const Text(
          'Recent Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 82,
                ),
                const SizedBox(height: 28),
                const Text(
                  "You're all caught up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Watch this space for news on your followers, '
                  'playlists, events, and more.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.68),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.68),
                      fontSize: 16,
                      height: 1.5,
                    ),
                    children: const [
                      TextSpan(
                        text:
                            'Looking for new releases? Check out the Following '
                            'feed for ',
                      ),
                      TextSpan(
                        text: 'Music',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' or ',
                      ),
                      TextSpan(
                        text: 'Podcasts',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}