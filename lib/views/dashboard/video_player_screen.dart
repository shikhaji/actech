
import 'package:ac_tech/widgets/primary_button.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../model/course_categoryid_model.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/constant.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/scrollview.dart';
import 'landscape_player_page.dart';

class VideoPlayerScreen extends StatefulWidget {
  final OtpArguments? arguments;
  const VideoPlayerScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  List<Course> getAllCourseDetails=[];

 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  final TextEditingController _search = TextEditingController();

  //VIDEO PLAYER
 late var videoURL = "${widget.arguments?.ccUrl.toString()}";
 late var pdfURL = "https://www.actechindia.org/uploads/${widget.arguments?.ccChapterPdf}";
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
                  PlaybackSpeedButton(),
                ],
            ),
            SizedBoxH34(),
            Align(
                alignment: Alignment.topLeft,
                child: appText("${widget.arguments?.ccChapterName}",style: AppTextStyle.title)
            ),
            SizedBoxH20(),


            Text("Lorem ipsum dolor sit amet. Ad culpa quia aut facilis accusantium autdolores quisquam aut sunt voluptatibus et Quis similique. Ex magni eiuseum harum ipsa hic rerum accusamus aut sint molestias. Aut consecteturtotam sit nihil vitae ex voluptatibus accusantium ut suscipit quae aut iureeaque et ",style: AppTextStyle.subTitle),
            // SizedBoxH30(),
            // // Row(
            // //   children:[Text("5 Lessons (8 hours)",style: AppTextStyle.alertSubtitle)],
            // // ),
            // // SizedBoxH10(),
            // // Container(
            // //   height: Sizes.s320,
            // //   child: SingleChildScrollView(
            // //     child: ListView.builder(
            // //       padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
            // //       shrinkWrap: true,
            // //       physics: const NeverScrollableScrollPhysics(),
            // //       itemCount: videos.length,
            // //       itemBuilder: (context, index) {
            // //         return  InkWell(
            // //           onTap: () =>_playVideo(index: index),
            // //           child: Padding(
            // //             padding:const EdgeInsets.symmetric(horizontal: 12),
            // //             child: Row(
            // //               children: [
            // //                 SizedBox(
            // //                   height: Sizes.s100,
            // //                   width: Sizes.s100,
            // //                   child: Image.network(
            // //                     videos[index].thumbnail,
            // //                     fit: BoxFit.contain,
            // //                   ),
            // //                 ),
            // //                 const SizedBox(
            // //                   width: Sizes.s20,
            // //                 ),
            // //                 Text(
            // //                   videos[index].name,
            // //                   style:AppTextStyle.title,
            // //                 ),
            // //               ],
            // //             ),
            // //           ),
            // //         );
            // //       },
            // //     ),
            // //   ),
            // // ),
            // //Container
            // SizedBoxH30(),
            // // Row(
            // //   children:[Text("5 Lessons (8 hours)",style: AppTextStyle.alertSubtitle)],
            // // ),
            // // SizedBoxH10(),
            // // Container(
            // //   height: Sizes.s320,
            // //   child: SingleChildScrollView(
            // //     child: ListView.builder(
            // //       padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
            // //       shrinkWrap: true,
            // //       physics: const NeverScrollableScrollPhysics(),
            // //       itemCount: videos.length,
            // //       itemBuilder: (context, index) {
            // //         return  InkWell(
            // //           onTap: () =>_playVideo(index: index),
            // //           child: Padding(
            // //             padding:const EdgeInsets.symmetric(horizontal: 12),
            // //             child: Row(
            // //               children: [
            // //                 SizedBox(
            // //                   height: Sizes.s100,
            // //                   width: Sizes.s100,
            // //                   child: Image.network(
            // //                     videos[index].thumbnail,
            // //                     fit: BoxFit.contain,
            // //                   ),
            // //                 ),
            // //                 const SizedBox(
            // //                   width: Sizes.s20,
            // //                 ),
            // //                 Text(
            // //                   videos[index].name,
            // //                   style:AppTextStyle.title,
            // //                 ),
            // //               ],
            // //             ),
            // //           ),
            // //         );
            // //       },
            // //     ),
            // //   ),
            // // ),
            // //Container
            SizedBoxH34(),

          ],

        ),

        appBar: SecondaryAppBar(
          title: "${widget.arguments?.ccCourseName}",
          isLeading: true,
          leadingIcon: Icons.arrow_back,
        ),
      bottomNavigationBar: Material(
        color:AppColor.primaryColor,
        child: InkWell(
          onTap: () {
            "https://www.actechindia.org/uploads/${widget.arguments?.ccChapterPdf}";
          },
          child: const SizedBox(
            height: Sizes.s50,
            width: double.infinity,
            child: Center(
              child: Text(
                'Download Course Materials',
                style: AppTextStyle.lable,
              ),
            ),
          ),
        ),
      ),
    );
  }

}


