import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_music_app/core/constants/colors.dart';
import 'package:my_music_app/features/music_player/presentation/bloc/player/player_bloc.dart';
import 'package:my_music_app/features/music_player/presentation/pages/detail_screen.dart';
import 'package:my_music_app/features/music_player/presentation/widgets/image_wrapper.dart';
import '../../domain/models/track_model.dart';

class BottomPlayer extends StatelessWidget {
  final Track track;
  const BottomPlayer({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        return ListTile(
          selectedColor: Colors.black,
          selected: true,
          selectedTileColor: Colors.white,
          title: Text(
            track.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          leading: SizedBox(
            height: 60.h,
            width: 60.h,
            child: ImageWrapper(
              image: track.image,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {
                context.read<PlayerBloc>().add(PlayPause(track: track));
              }, icon: BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, state) {
                  return Icon(
                    (state.isPlaying && (state.track == track))
                        ? CupertinoIcons.pause_fill
                        : CupertinoIcons.play_arrow_solid,
                    color: AppColors.primaryColor,
                  );
                },
              )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    color: AppColors.primaryColor,
                  )),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailScreen(),
                ));
            return;
          },
        );
      },
    );
  }
}
