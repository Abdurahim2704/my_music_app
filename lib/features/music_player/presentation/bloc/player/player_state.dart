part of 'player_bloc.dart';

@immutable
abstract class PlayerState extends Equatable {
  final Track? track;
  final bool isPlaying;

  const PlayerState({this.track, this.isPlaying = false});
  @override
  List<Object?> get props => [track, isPlaying];
}

class PlayerInitial extends PlayerState {
  const PlayerInitial({super.track, super.isPlaying = false});
}

class PlayerLoading extends PlayerState {
  const PlayerLoading({required super.track, super.isPlaying});
}

class PlayerSuccessState extends PlayerState {
  const PlayerSuccessState({required super.track, super.isPlaying});
}

class PlayerErrorState extends PlayerState {
  const PlayerErrorState({required super.track, super.isPlaying});
}
