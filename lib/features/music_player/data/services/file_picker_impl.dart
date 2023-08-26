import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:my_music_app/features/music_player/data/services/permission_handler.dart';
import 'package:my_music_app/features/music_player/domain/models/track_model.dart';
import 'package:my_music_app/features/music_player/domain/repositories/files_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FileRepositoryImpl implements FilesRepository {
  final StreamController<List<Track>> _controller =
      StreamController<List<Track>>.broadcast();
  final List<Track> _tracks = [];

  @override
  void pickMp3File() async {
    final permission = await PermissionHandler.audioPermission();
    if (permission || await PermissionHandler.isGrantedAudio) {
      final OnAudioQuery audioQuery = OnAudioQuery();
      final List<SongModel> data = await audioQuery.querySongs();

      for (var e in data) {
        try {
          final name = e.title;
          final path = e.data;
          final duration = Duration(milliseconds: e.duration ?? 0);
          final image = await audioQuery.queryArtwork(e.id, ArtworkType.AUDIO);

          if (duration.inSeconds < 5) {
            continue;
          }

          _tracks.add(
              Track(name: name, path: path, duration: duration, image: image));
        } catch (e) {
          continue;
        }
      }
    }
  }

  @override
  Stream<List<Track>> get stream => _controller.stream;

  @override
  List<Track> get tracks => _tracks;
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState);

  void pickMp3File(List<dynamic> list) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(list[1]);
    final OnAudioQuery audioQuery = OnAudioQuery();
    final List<SongModel> data = await audioQuery.querySongs();
    final List<Track> tracks = [];
    for (var e in data) {
      try {
        final name = e.title;
        final path = e.data;
        final duration = Duration(milliseconds: e.duration ?? 0);
        final image = await audioQuery.queryArtwork(e.id, ArtworkType.AUDIO);

        if (duration.inSeconds < 5) {
          continue;
        }

        tracks.add(
            Track(name: name, path: path, duration: duration, image: image));
      } catch (e) {
        continue;
      }
    }
    list[0].send(tracks);
    emit(HomeState(tracks));
  }
}

class HomeState {
  final List<Track> tracks;

  const HomeState(this.tracks);
}
