part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
  @override
  List<Object?> get props => [];
}

class PlayPause extends PlayerEvent {
  final Track track;

  const PlayPause({required this.track});

  @override
  List<Object?> get props => [track];
}

class SeekPosition extends PlayerEvent {
  final Duration position;

  const SeekPosition({
    required this.position,
  });
}

class SkipNext extends PlayerEvent {}
