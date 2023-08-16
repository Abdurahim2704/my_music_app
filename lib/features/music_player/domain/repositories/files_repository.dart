import 'dart:async';

import 'package:my_music_app/features/music_player/domain/models/track_model.dart';

abstract class FilesRepository {
  void pickMp3File();
  Stream<List<Track>> get stream;
  List<Track> get tracks ;
}
