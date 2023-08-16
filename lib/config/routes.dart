
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_music_app/features/music_player/presentation/screens/home_screens.dart';

class Routes {
  static const home = "/";
  static const detail = "/detail";

  static String get getHome => home;
  static String get getDetail => detail;

  static List<GetPage> get routes => [
    GetPage(name: home, page: () => const HomePage(),),
  ];
}

