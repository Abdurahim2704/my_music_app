import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_music_app/core/service_locator.dart';
import 'package:my_music_app/features/music_player/domain/repositories/audio_repository.dart';

import '../../../domain/models/track_model.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerInitial()) {
    on<PlayPause>(_playPause);
    on<SeekPosition>(_seekPosition);
    on<SkipNext>(_skipNext);
  }

  Future<void> _playPause(PlayPause event, Emitter<PlayerState> emit) async {
    final audioService = getIt<AudioRepository>();
    emit(PlayerLoading(track: state.track, isPlaying: state.isPlaying));
    if ((event.track == state.track) && state.isPlaying) {
      audioService.pause();
      emit(PlayerSuccessState(track: event.track, isPlaying: false));
    } else if (event.track == state.track) {
      audioService.play();
      emit(PlayerSuccessState(track: event.track, isPlaying: true));
    } else {
      audioService.playNewTrack(event.track);
      emit(PlayerSuccessState(track: event.track, isPlaying: true));
    }
  }

  Future<void> _seekPosition(
      SeekPosition event, Emitter<PlayerState> emit) async {
    final service = getIt<AudioRepository>();
    await service.seekDuration(event.position);
  }

  Future<void> _skipNext(SkipNext event, Emitter<PlayerState> emit) async {
    final service = getIt<AudioRepository>();
    await service.skipNext();
    emit(PlayerSuccessState(
        track: service.currentTrack, isPlaying: state.isPlaying));
  }
}
