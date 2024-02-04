import 'dart:async';
import 'package:my_music_app/features/music_player/data/services/permission_handler.dart';
import 'package:my_music_app/features/music_player/domain/models/track_model.dart';
import 'package:my_music_app/features/music_player/domain/repositories/files_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FileRepositoryImpl implements FilesRepository {
  final List<Track> _tracks = [];
  @override
  Future<List<Track>> pickMp3File() async {
    final List<Track> track = [];
    if (!(await PermissionHandler.isGrantedAudio)) {
      await PermissionHandler.audioPermission();
    }
    if (await PermissionHandler.isGrantedAudio) {
      final OnAudioQuery audioQuery = OnAudioQuery();
      final List<SongModel> data = await audioQuery.querySongs();

      for (var e in data) {
        try {
          final name = e.title;
          final path = e.data;
          final String author = (e.artist ?? "Unknown");
          final duration = Duration(milliseconds: e.duration ?? 0);
          final image = await audioQuery.queryArtwork(e.id, ArtworkType.AUDIO);
          if (duration.inSeconds < 5) {
            continue;
          }

          track.add(Track(
              name: name,
              path: path,
              duration: duration,
              image: image,
              author: author));
        } catch (e) {
          continue;
        }
      }
    }
    _tracks.addAll(track);
    return track;
  }

  @override
  List<Track> get tracks => _tracks;
}
