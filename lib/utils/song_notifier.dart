import 'package:flutter/material.dart';
import 'package:spotify/utils/dummy_data.dart';

class SongNotifier {
  static final ValueNotifier<Map<String, String>> currentTrack = ValueNotifier(tracksList[0]);

  static void selectTrack(Map<String, String> newTrack) {
    currentTrack.value = newTrack;
  }
}