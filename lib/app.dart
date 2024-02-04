import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_music_app/config/theme/theme.dart';
import 'package:my_music_app/features/music_player/presentation/bloc/player/player_bloc.dart';
import 'package:my_music_app/features/music_player/presentation/pages/home_screens.dart';

import 'features/music_player/presentation/bloc/home/home_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return HomeBloc()..add(FetchMusic());
          },
        ),
        BlocProvider(create: (context) => PlayerBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          home: HomePage(),
        ),
      ),
    );
  }
}
