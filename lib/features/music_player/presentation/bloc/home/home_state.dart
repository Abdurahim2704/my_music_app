part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final List<Track> tracks;
  final Track? track;
  const HomeState({required this.tracks, this.track});
  @override
  List<Object?> get props => [tracks];
}

class HomeInitial extends HomeState {
  const HomeInitial() : super(tracks: const []);
}

class HomeLoading extends HomeState {
  const HomeLoading({required super.tracks, super.track});
}

class HomeFetchError extends HomeState {
  final String message;
  const HomeFetchError(
      {required this.message, required super.tracks, super.track});
}

class HomeFetchSuccess extends HomeState {
  const HomeFetchSuccess({required super.tracks, super.track});
}
