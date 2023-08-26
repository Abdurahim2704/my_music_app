import 'dart:io';

import 'package:my_music_app/features/music_player/data/services/audio_service_impl.dart';
import 'package:my_music_app/features/music_player/presentation/screens/home_screens.dart';
late File file;
late AudioServiceImpl audioServiceImpl;
void serviceLocator() async {
  audioServiceImpl = AudioServiceImpl(tracks: cubit.state.tracks);
}
