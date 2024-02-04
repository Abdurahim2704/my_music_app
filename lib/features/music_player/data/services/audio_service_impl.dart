import 'package:just_audio/just_audio.dart';
import 'package:my_music_app/core/service_locator.dart';
import 'package:my_music_app/features/music_player/domain/models/track_model.dart';
import 'package:my_music_app/features/music_player/domain/repositories/audio_repository.dart';
import 'package:my_music_app/features/music_player/domain/repositories/files_repository.dart';

class AudioServiceImpl extends AudioRepository {
  final player = AudioPlayer();
  final List<Track> tracks = [];
  int current = 0;
  @override
  Future<void> playNewTrack(Track track) async {
    await player.setUrl(track.path);
    await player.play();
    current = tracks.indexOf(track);
  }

  @override
  Future<void> init() async {
    tracks.addAll(getIt<FilesRepository>().tracks);
  }

  @override
  Future<bool> get isPlaying async => player.playing;

  @override
  Future<void> pause() async {
    await player.pause();
  }

  @override
  Future<void> play() async {
    await player.play();
  }

  @override
  Stream<Duration> audioDuration() {
    return player.positionStream;
  }

  @override
  Future<void> seekDuration(Duration position) async {
    await player.seek(position);
  }

  @override
  Future<void> skipNext() async {
    await playNewTrack(tracks[(current + 1)]);
  }

  @override
  void setAudio(List<Track> myTrack) {
    tracks.addAll(myTrack);
  }

  @override
  Future<void> skipPrevious() async {
    await player.seekToPrevious();
  }

  @override
  Track get currentTrack => tracks[current];
}
