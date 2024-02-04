import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_music_app/core/constants/colors.dart';
import 'package:my_music_app/features/music_player/presentation/widgets/bottom_player.dart';
import 'package:my_music_app/features/music_player/presentation/widgets/music_tile.dart';
import 'package:my_music_app/features/music_player/presentation/widgets/widgets.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/player/player_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${state.tracks.length} songs",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 19.sp),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Ascending",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: AppColors.primaryColor),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          CupertinoIcons.arrow_up_arrow_down,
                          color: AppColors.primaryColor,
                          size: 19.sp,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade300),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final track = state.tracks[index];
                      return MusicTile(track: track);
                    },
                    itemCount: state.tracks.length,
                  ),
                ),
              ),
              if (context.watch<PlayerBloc>().state is PlayerSuccessState)
                BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomPlayer(
                        track: state.track!,
                      ),
                    );
                  },
                )
            ],
          );
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: Padding(
          padding: EdgeInsets.only(top: 8.sp),
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.house),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.heart),
                  label: "Heart",
                  activeIcon: Icon(FontAwesomeIcons.solidHeart)),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.list), label: "Safety"),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.user),
                  label: "Safety",
                  activeIcon: Icon(FontAwesomeIcons.solidUser)),
            ],
            selectedLabelStyle: const TextStyle(
                color: AppColors.primaryColor, fontWeight: FontWeight.w700),
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
            selectedIconTheme:
                const IconThemeData(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
