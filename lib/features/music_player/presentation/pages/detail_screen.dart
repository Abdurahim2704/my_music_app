import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_music_app/core/constants/colors.dart';
import 'package:my_music_app/core/constants/constants.dart';
import 'package:my_music_app/core/service_locator.dart';
import 'package:my_music_app/features/music_player/domain/repositories/audio_repository.dart';
import 'package:my_music_app/features/music_player/presentation/widgets/control_button.dart';
import 'package:my_music_app/features/music_player/presentation/widgets/image_wrapper.dart';

import '../bloc/player/player_bloc.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz_rounded,
                color: Colors.black.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
              ))
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColors.gradientOrange,
                        AppColors.gradient2,
                      ],
                    ),
                  ),
                ),
              )),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 300.h,
                    width: 300.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: ImageWrapper(
                            image:
                                context.read<PlayerBloc>().state.track!.image)),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  context.read<PlayerBloc>().state.track!.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 29.sp,
                    color: Colors.black.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  context.read<PlayerBloc>().state.track!.author,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                    color: Colors.black.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                StreamBuilder<Duration>(
                    stream: getIt<AudioRepository>().audioDuration(),
                    initialData: const Duration(seconds: 0),
                    builder: (context, snapshot) {
                      return ProgressBar(
                        progress: snapshot.data!,
                        total: context.read<PlayerBloc>().state.track!.duration,
                        timeLabelTextStyle: TextStyle(
                            color: Colors.black.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                            fontSize: 16.sp,
                            height: 1.6),
                        progressBarColor: Colors.orange,
                        thumbColor: AppColors.primaryColor,
                        thumbRadius: 9,
                        thumbGlowRadius: 18,
                        baseBarColor: Colors.white,
                        onSeek: (value) {
                          context
                              .read<PlayerBloc>()
                              .add(SeekPosition(position: value));
                        },
                      );
                    }),
                BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ControlButton(
                          icon: CustomIcons.fastBack,
                          size: 50.h,
                          onPressed: () {},
                        ),
                        ControlButton(
                          icon: CustomIcons.skipBack,
                          size: 50.h,
                          onPressed: () {},
                        ),
                        ControlButton(
                          icon: state.isPlaying
                              ? CustomIcons.pause
                              : CustomIcons.play,
                          size: 60.h,
                          onPressed: () {
                            context.read<PlayerBloc>().add(PlayPause(
                                track:
                                    context.read<PlayerBloc>().state.track!));
                          },
                        ),
                        ControlButton(
                          icon: CustomIcons.skipNext,
                          size: 50.h,
                          onPressed: () async {
                            await getIt<AudioRepository>().skipNext();
                          },
                        ),
                        ControlButton(
                          icon: CustomIcons.fastForward,
                          size: 50.h,
                          onPressed: () async {
                            await getIt<AudioRepository>().skipPrevious();
                          },
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
