import 'package:flutter/material.dart';
import 'package:spotify/utils/dummy_data.dart';

class SongNotifier {
  static final ValueNotifier<Map<String, String>> currentTrack = ValueNotifier(tracksList[0]);

  static void selectTrack(Map<String, String> newTrack) {
    currentTrack.value = newTrack;
  }

  static void nextTrack() {
    final currentIndex = tracksList.indexWhere(
      (track) => track['title'] == currentTrack.value['title'],
    );

    if (currentIndex != -1 && currentIndex < tracksList.length - 1) {
      // Pindah ke lagu selanjutnya
      currentTrack.value = tracksList[currentIndex + 1];
    } else {
      // Jika sudah di lagu terakhir, kembali ke lagu pertama
      currentTrack.value = tracksList[0];
    }
  }
}