import 'package:my_music_app/features/music_player/domain/models/track_model.dart';

abstract class FilesRepository {
  List<Track> get tracks;
  Future<List<Track>> pickMp3File();
}
