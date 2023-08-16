import 'dart:async';

import 'package:audiotagger/audiotagger.dart';
import 'package:my_music_app/features/music_player/data/services/permission_handler.dart';
import 'package:my_music_app/features/music_player/domain/models/track_model.dart';
import 'package:my_music_app/features/music_player/domain/repositories/files_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';


class FileRepositoryImpl implements FilesRepository {
  final StreamController<List<Track>> _controller = StreamController<List<Track>>.broadcast();
  List<Track> _tracks = [];

  @override
  void pickMp3File() async {
    final permission = await PermissionHandler.audioPermission();
    if (permission || await PermissionHandler.isGrantedAudio) {
      final OnAudioQuery audioQuery = OnAudioQuery();
      final tagger = Audiotagger();
      final List<SongModel> data = await audioQuery.querySongs();
      final musics = <Track>[];
      for (var e in data) {
        try {
          final name = e.title;
          final path = e.data;
          final duration = Duration(milliseconds: e.duration ?? 0);
          if (duration.inSeconds < 5) {
            continue;
          }
          final image = await tagger.readArtwork(path: path);
          musics.add(Track(name: name, path: path, duration: duration, image: image));
        }
        catch (e) {
          continue;
        }
      }

      _tracks = musics;
      _controller.sink.add(musics);
    }
  }

  @override
  Stream<List<Track>> get stream => _controller.stream;

  @override
  List<Track> get tracks => _tracks;
}
