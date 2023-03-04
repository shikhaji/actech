

import 'package:ac_tech/widgets/primary_button.dart';
import 'package:ac_tech/widgets/primary_padding.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/course_category_model.dart';
import '../../routes/arguments.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/scrollview.dart';

class CourseBuyScreen extends StatefulWidget {

  const CourseBuyScreen({Key? key}) : super(key: key);

  @override
  State<CourseBuyScreen> createState() => _CourseBuyScreenState();
}



class _CourseBuyScreenState extends State<CourseBuyScreen> {
  List<Course> getAllCourseDetails = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  final TextEditingController _search = TextEditingController();

  //VIDEO PLAYER
  late var videoURL = "https://www.youtube.com/watch?v=DIqB8qEZW1U";

  late YoutubePlayerController _controller;
  double? _progress;


  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        loop: false,
        hideThumbnail: true,
      ),
    );
    super.initState();

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PrimaryPadding(
          child: Column(
            children: [
              SizedBoxH28(),

              Column(
                children: [
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () => debugPrint("Ready"),
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(
                        isExpanded: true,

                        colors: const ProgressBarColors(
                          playedColor: AppColor.primaryColor,
                          handleColor: AppColor.primaryLightColor,
                        ),
                      ),
                      RemainingDuration(),
                      PlaybackSpeedButton(),
                    ],
                  ),
                  SizedBoxH20(),
                  PrimaryButton(lable: "Enroll for Rs4000", onPressed: (){}),
                ],
              ),
              SizedBoxH10(),
              Divider(
                thickness: 1,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: PrimaryPadding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appText("Demo Page",
                            style: AppTextStyle.title),
                        SizedBoxH120(),
                        SizedBoxH120(),
                        SizedBoxH120(),
                        Text(
                            "This is Demo Page DescriptionThis is Demo Page DescriptionThis is Demo Page DescriptionThis is Demo Page DescriptionThis is Demo Page DescriptionThis is Demo Page DescriptionThis is Demo Page Description",
                            style: AppTextStyle.subTitle),
                      ],
                    ),
                  ),
                ),
              ),



            ],
          ),
        ),



      ),

      appBar: SecondaryAppBar(
        title: "Details",
        isLeading: true,
        leadingIcon: Icons.arrow_back,
      ),
    );
  }


}


