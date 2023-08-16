import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_music_app/core/service_locator.dart';
import 'package:my_music_app/features/music_player/domain/models/track_model.dart';
import 'package:my_music_app/features/music_player/presentation/screens/detail_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    repository.pickMp3File();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_image.jpg",),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder<List<Track>>(
          stream: repository.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final data = snapshot.data!;
              audioServiceImpl.playlistLoad(repository);
              return ListView.builder(itemBuilder: (context, index) {
                final track = data[index];
                return MusicCart(
                  child: ListTile(
                    title: Text(track.name, maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: currentIndex == index ? Colors.yellow : Colors.black),),
                    subtitle: Text(track.duration.durationFormatter, style: TextStyle(color: currentIndex == index ? Colors.yellow : Colors.black),),
                    onTap: () async {
                      await audioServiceImpl.onMusicTap(index);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(track: track)));
                    },
                    leading: SizedBox(height: 60, width: 60, child: track.image != null ? Image.memory(track.image!,) : Image.asset("assets/images/default.png"),),
                  ),
                );
              },itemCount: data.length,);
            }
            return const LoadingPage();
          },
        )
      ),
    );
  }
}

class MusicCart extends StatefulWidget {
  final Widget child;
  const MusicCart({
    super.key,
    required this.child,
  });

  @override
  State<MusicCart> createState() => _MusicCartState();
}

class _MusicCartState extends State<MusicCart> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(),),
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.withOpacity(0.16),
                    Colors.blue.withOpacity(0.05),
                  ]
                )
              ),
            ),
           widget.child
          ],
        ),
      ),
    );
  }
}


class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.16),
      body: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

extension on Duration {
  String get  durationFormatter {
    String formattedDuration = '${(inMinutes % 60).toString().padLeft(2, '0')}:${(inSeconds % 60).toString().padLeft(2, '0')}';
    return formattedDuration;
  }
}