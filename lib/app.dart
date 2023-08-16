import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_music_app/config/routes.dart';
import 'package:my_music_app/features/music_player/presentation/screens/home_screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.getHome,
      getPages: Routes.routes,
      home:  const HomePage(),
    );
  }
}
