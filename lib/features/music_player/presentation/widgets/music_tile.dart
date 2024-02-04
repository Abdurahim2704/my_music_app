import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_music_app/core/constants/colors.dart';
import 'package:my_music_app/features/music_player/presentation/bloc/player/player_bloc.dart';
import 'package:my_music_app/features/music_player/presentation/widgets/image_wrapper.dart';
import 'package:my_music_app/main.dart';
import '../../domain/models/track_model.dart';

class MusicTile extends StatelessWidget {
  final Track track;
  const MusicTile({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            track.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: state.track == track
                    ? AppColors.primaryColor
                    : Colors.black,
                fontWeight: FontWeight.w600),
          ),
          subtitle: Row(
            children: [
              SizedBox(
                width: 100.w,
                child: Text(
                  track.author,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Text("|"),
              const SizedBox(
                width: 10,
              ),
              Text(track.duration.durationFormatter,
                  overflow: TextOverflow.ellipsis),
            ],
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
                  return Icon((state.isPlaying && (state.track == track))
                      ? CupertinoIcons.pause
                      : CupertinoIcons.play);
                },
              )),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
          onTap: () {
            context.read<PlayerBloc>().add(PlayPause(track: track));
            return;
          },
        );
      },
    );
  }
}
