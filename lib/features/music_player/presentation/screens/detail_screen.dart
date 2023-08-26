import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_music_app/core/service_locator.dart';
import 'package:my_music_app/features/music_player/presentation/screens/home_screens.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../domain/models/track_model.dart';
import '../constants/CustomIcons.dart';
import '../utils/glassmorphic.dart';

class DetailPage extends StatefulWidget {
  final Track track;
  const DetailPage({super.key, required this.track});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PageController _pageController = PageController();
  final artistName = "UnKnown";
  Image image = Image.asset("assets/images/default.png");

  int index = 0;
  bool _pauseIcon = false;
  List<NetworkImage> listOfImage = [
    const NetworkImage(
        "https://pbs.twimg.com/profile_images/1431129444362579971/jGrgSKDD_400x400.jpg"),
  ];

  List<AssetImage> listOfIcons = [
    CustomIcons.like,
    CustomIcons.cut,
    CustomIcons.timer,
    CustomIcons.share,
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    image = widget.track.image != null ? Image.memory(widget.track.image!,) : image;
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: image.image,
        ),
      ),
      child: GlassMorphic(
        beginColor: const Color(0xff353F54).withOpacity(0.3),
        endColor: const Color(0xff222834).withOpacity(0.3),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                setState(() {
                  debugPrint("on tapped");
                });
              },
              icon: const Image(
                height: 10,
                fit: BoxFit.fitHeight,
                image: AssetImage("assets/icons/Back.png"),
              ),
            ),
            backgroundColor: Colors.transparent,
            title: Column(
              children: [
                Text(
                  widget.track.name,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
                Text(
                  artistName,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              PopupMenuButton(
                icon: const Image(
                  height: 25,
                  fit: BoxFit.fitHeight,
                  image: CustomIcons.menu,
                ),
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                        value: Locale("uz", "UZ"), child: Text("🇺🇿 UZ")),
                    PopupMenuItem(
                        value: Locale("ru", "RU"), child: Text("🇷🇺 RU")),
                    PopupMenuItem(
                        value: Locale("en", "US"), child: Text("🇺🇸 EN")),
                  ];
                },
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).width,
                  width: MediaQuery.sizeOf(context).width,
                  child: PageView(
                    onPageChanged: (value) {
                      index = value;
                      setState(() {});
                    },
                    controller: _pageController,
                    children: [
                      image
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              const SizedBox(
                height: 10,
              ),
              SmoothPageIndicator(
                controller: _pageController, // PageController
                count: listOfImage.length,
                effect: const WormEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: Colors.white,
                    paintStyle: PaintingStyle.fill,
                    activeDotColor: Colors.black), // your preferred effect
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.suit_heart,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image(
                      fit: BoxFit.fitHeight,
                      height: 25,
                      width: 25,
                      color: Colors.white,
                      image: listOfIcons[1],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image(
                      fit: BoxFit.fitHeight,
                      height: 35,
                      width: 35,
                      color: Colors.white,
                      image: listOfIcons[2],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image(
                      fit: BoxFit.fitHeight,
                      height: 40,
                      width: 40,
                      color: Colors.white,
                      image: listOfIcons[3],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: StreamBuilder(
                  stream: audioServiceImpl.player.positionStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ProgressBar(
                        thumbGlowRadius: 18,
                        baseBarColor: Colors.white60,
                        thumbColor: Colors.white,
                        timeLabelTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 17),
                        progress: snapshot.data ?? const Duration(),
                        buffered: audioServiceImpl.player.bufferedPosition,
                        onSeek: (value) {
                          audioServiceImpl.player.seek(value);
                        },
                        total:widget.track.duration,
                      );
                    }
                    return const LoadingPage();
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Image(
                      fit: BoxFit.fitHeight,
                      height: 45,
                      width: 45,
                      color: Colors.white,
                      image: CustomIcons.continueIcon,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Image(
                      fit: BoxFit.fitHeight,
                      height: 35,
                      width: 35,
                      color: Colors.white,
                      image: CustomIcons.backIcon,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                        iconSize: 50,
                        onPressed: () async {
                          _pauseIcon = !_pauseIcon;
                          audioServiceImpl.player.playing ? await audioServiceImpl.player.pause() : await audioServiceImpl.player.play();
                          setState(() {});
                        },

                        icon: Icon(
                          _pauseIcon
                              ? Icons.play_arrow_rounded
                              : Icons.pause_rounded,
                          color: Colors.white,
                        ),
                        // icon: const Icon(
                        //   Icons.pause_rounded,
                        //   color: Colors.white,
                        // ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Image(
                      fit: BoxFit.fitHeight,
                      height: 35,
                      width: 35,
                      color: Colors.white,
                      image: CustomIcons.nextIcon,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Image(
                      fit: BoxFit.contain,
                      height: 40,
                      width: 40,
                      color: Colors.white,
                      image: CustomIcons.playlistIcon,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
