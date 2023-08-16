import 'dart:io';

import 'package:my_music_app/features/music_player/data/services/audio_service_impl.dart';
import 'package:my_music_app/features/music_player/data/services/file_picker_impl.dart';
import 'package:my_music_app/features/music_player/domain/repositories/files_repository.dart';

late File file;
late FilesRepository repository;
late AudioServiceImpl audioServiceImpl;
void serviceLocator() async {
  repository = FileRepositoryImpl();
  repository.pickMp3File();
  repository.stream;
  audioServiceImpl = AudioServiceImpl(tracks: repository.tracks);
}
