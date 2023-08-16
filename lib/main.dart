import 'package:flutter/cupertino.dart';
import 'package:my_music_app/app.dart';
import 'package:my_music_app/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocator();

  runApp(const MyApp());
}
