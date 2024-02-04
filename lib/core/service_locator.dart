import 'package:get_it/get_it.dart';
import 'package:my_music_app/features/music_player/data/services/audio_service_impl.dart';
import 'package:my_music_app/features/music_player/data/services/file_picker_impl.dart';
import 'package:my_music_app/features/music_player/domain/repositories/audio_repository.dart';
import 'package:my_music_app/features/music_player/domain/repositories/files_repository.dart';

final getIt = GetIt.instance;
Future<void> serviceLocator() async {
  getIt.registerSingleton<AudioRepository>(AudioServiceImpl());
  getIt.registerSingleton<FilesRepository>(FileRepositoryImpl());
}
