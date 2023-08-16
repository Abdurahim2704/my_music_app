import 'package:my_music_app/features/music_player/domain/models/track_model.dart';


class Playlist {
  String name;
  List<Track> tracks;

  Playlist({
    required this.name,
    required this.tracks,
  });
}
