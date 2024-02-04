part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class FetchMusic extends HomeEvent {}

class TrackChanging extends HomeEvent {
  final Track track;
  const TrackChanging({required this.track});
}
