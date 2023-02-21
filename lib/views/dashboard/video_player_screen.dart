import 'dart:io';
import 'package:ac_tech/views/dashboard/landscape_player_page.dart';
import 'package:ac_tech/widgets/primary_button.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../model/course_categoryid_model.dart';
import '../../routes/arguments.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/scrollview.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class VideoPlayerScreen extends StatefulWidget {
  final OtpArguments? arguments;
  const VideoPlayerScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}



class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  List<Course> getAllCourseDetails = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  final TextEditingController _search = TextEditingController();

  //VIDEO PLAYER
  late var videoURL = "${widget.arguments?.ccUrl.toString()}";
  late var pdfURL = "https://www.actechindia.org/uploads/${widget.arguments
      ?.ccChapterPdf}";
  late YoutubePlayerController _controller;
  double? _progress;


  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: false,

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
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () => debugPrint("Ready"),
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,

                colors: ProgressBarColors(
                  playedColor: AppColor.primaryColor,
                  handleColor: AppColor.primaryLightColor,
                ),
              ),
              RemainingDuration(),
              PlaybackSpeedButton(),
              FullScreenButton(),
            ],
          ),
        ],
      ),


      appBar: SecondaryAppBar(
        title: "${widget.arguments?.ccCourseName}",
        isLeading: true,
        leadingIcon: Icons.arrow_back,
      ),
      bottomNavigationBar: _progress!=null?SizedBox(width: 5 , height: 5.h,child: CircularProgressIndicator()):Material(
        color: AppColor.primaryColor,
        child: InkWell(
          onTap: () {
              FileDownloader.downloadFile(url: pdfURL.trim(),
              onProgress: (name, progress){
                setState(() {
                  _progress = progress;

                });
              },
              onDownloadCompleted: (value){
                print('path $value');
                setState(() {
                  _progress = null;
                });
                Fluttertoast.showToast(
                  msg: 'Download Successfully',
                  backgroundColor: Colors.grey,
                );
              }
            );
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


