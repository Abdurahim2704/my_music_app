import 'package:just_audio/just_audio.dart';
import 'package:my_music_app/features/music_player/data/services/file_picker_impl.dart';

import '../../domain/models/track_model.dart';

class AudioServiceImpl{
  List<Track> tracks;
  final AudioPlayer _player = AudioPlayer();
  int currentIndex = 0;

  AudioServiceImpl({required this.tracks});


  void playlistLoad(HomeCubit cubit) async {
    tracks = cubit.state.tracks;
    final audioSource = ConcatenatingAudioSource(children: [
      for (var track in tracks)
        AudioSource.file(track.path)
    ]);
    await _player.setAudioSource(audioSource, initialIndex: currentIndex);
    await _player.load();
  }

  Future<void> onMusicTap(int index) async {
    if (index == currentIndex) {
      _player.playing ? await _player.pause() : _player.play();
      return;
    }

    await _player.seek(null, index: index);
    currentIndex = index;
    _player.play();
    return;
  }

  AudioPlayer get player => _player;


}