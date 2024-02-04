import '../models/track_model.dart';

abstract class AudioRepository {
  Future<void> play();
  Future<void> init();
  Future<bool> get isPlaying;
  Future<void> pause();
  Future<void> playNewTrack(Track myTrack);
  void setAudio(List<Track> track);

  Stream<Duration> audioDuration();
  Future<void> seekDuration(Duration position);

  Future<void> skipNext();
  Future<void> skipPrevious();
  Track get currentTrack;
}
