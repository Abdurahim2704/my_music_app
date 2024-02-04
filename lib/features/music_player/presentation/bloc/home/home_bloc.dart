import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:my_music_app/core/service_locator.dart';
import 'package:my_music_app/features/music_player/domain/repositories/files_repository.dart';

import '../../../domain/models/track_model.dart';
import '../../../domain/repositories/audio_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<FetchMusic>(_fetchMusic);
    on<TrackChanging>(_trackChanging);
  }

  void _fetchMusic(FetchMusic event, Emitter<HomeState> emit) async {
    emit(HomeLoading(tracks: state.tracks));
    final token = RootIsolateToken.instance;
    await complexWork(token);
  }

  void _trackChanging(TrackChanging event, Emitter<HomeState> emit) async {
    emit(HomeLoading(tracks: state.tracks, track: state.track));
    emit(HomeFetchSuccess(tracks: state.tracks, track: event.track));
  }

  Future<void> complexWork(RootIsolateToken? token) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(token!);

    final receivePort = ReceivePort();
    await Isolate.spawn(_isolateEntryPoint,
        [receivePort.sendPort, getIt<FilesRepository>(), token]);
    receivePort.listen((message) {
      emit(HomeFetchSuccess(
          tracks: (message as List).map((e) => e as Track).toList()));
      getIt<AudioRepository>()
          .setAudio((message).map((e) => e as Track).toList());
    });
  }
}

void _isolateEntryPoint(List<dynamic> message) async {
  final token = message[2] as RootIsolateToken?;
  BackgroundIsolateBinaryMessenger.ensureInitialized(token!);
  SendPort sendPort = message[0];
  final pickMp3File = await (message[1] as FilesRepository).pickMp3File();
  sendPort.send(pickMp3File);
}
