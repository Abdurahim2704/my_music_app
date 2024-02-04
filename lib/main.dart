import 'package:flutter/cupertino.dart';
import 'package:my_music_app/app.dart';
import 'package:my_music_app/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();
  runApp(const MyApp());
}

extension DurationToString on Duration {
  String get durationFormatter {
    String formattedDuration =
        '${(inMinutes % 60).toString().padLeft(2, '0')}:${(inSeconds % 60).toString().padLeft(2, '0')}';
    return formattedDuration;
  }
}
