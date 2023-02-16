import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/scrollview.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  final TextEditingController _search = TextEditingController();

  //VIDEO PLAYER
 final videoURL ="https://www.youtube.com/watch?v=zu6E3I-YXzc";
 late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID =YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ),
    );
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScroll(
          children: [
            SizedBoxH10(),
            YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () => debugPrint("Ready"),
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,

                    colors:ProgressBarColors(
                      playedColor: AppColor.primaryColor,
                      handleColor: AppColor.primaryLightColor,
                    ),
                  ),
                  RemainingDuration(),
                  GestureDetector(
                      child: FullScreenButton()),
                ],
            ),
            SizedBoxH34(),
            Align(
                alignment: Alignment.topLeft,
                child: appText("Flutter Beginners",style: AppTextStyle.title)
            ),
            SizedBoxH10(),
            Text("Lorem ipsum dolor sit amet. Ad culpa quia aut facilis accusantium autdolores quisquam aut sunt voluptatibus et Quis similique. Ex magni eiuseum harum ipsa hic rerum accusamus aut sint molestias. Aut consecteturtotam sit nihil vitae ex voluptatibus accusantium ut suscipit quae aut iureeaque et ",style: AppTextStyle.subTitle),
            SizedBoxH30(),
            // Row(
            //   children:[Text("5 Lessons (8 hours)",style: AppTextStyle.alertSubtitle)],
            // ),
            // SizedBoxH10(),
            // Container(
            //   height: Sizes.s320,
            //   child: SingleChildScrollView(
            //     child: ListView.builder(
            //       padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemCount: videos.length,
            //       itemBuilder: (context, index) {
            //         return  InkWell(
            //           onTap: () =>_playVideo(index: index),
            //           child: Padding(
            //             padding:const EdgeInsets.symmetric(horizontal: 12),
            //             child: Row(
            //               children: [
            //                 SizedBox(
            //                   height: Sizes.s100,
            //                   width: Sizes.s100,
            //                   child: Image.network(
            //                     videos[index].thumbnail,
            //                     fit: BoxFit.contain,
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   width: Sizes.s20,
            //                 ),
            //                 Text(
            //                   videos[index].name,
            //                   style:AppTextStyle.title,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            //Container

          ],
        ),
        appBar: SecondaryAppBar(
          title: "Introduction",
          isLeading: true,
          leadingIcon: Icons.arrow_back,
        )
    );
  }

}


