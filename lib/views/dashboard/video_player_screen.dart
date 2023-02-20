import 'dart:io';

import 'package:ac_tech/views/dashboard/downloading_dialog.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

/*abstract class DownloadService {
  Future<void> download({required String url});
}


class MobileDownloadService implements DownloadService {
  @override
  Future<void> download({required String url}) async {
    // requests permission for downloading the file
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return;

    // gets the directory where we will download the file.
    var dir = await getApplicationDocumentsDirectory();

    // You should put the name you want for the file here.
    // Take in account the extension.
    String fileName = 'loro';

    // downloads the file
    Dio dio = Dio();
    await dio.download(url, "${dir.path}/$fileName");

    // opens the file
    OpenFile.open("${dir.path}/$fileName", type: 'application/pdf');
  }

  // requests storage permission
  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }
}*/

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
          SizedBoxH34(),
          Align(
              alignment: Alignment.topLeft,
              child: appText("${widget.arguments?.ccChapterName}",
                  style: AppTextStyle.title)
          ),
          SizedBoxH20(),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${widget.arguments?.ccDesc}",
               style: AppTextStyle.subTitle),
          ),
          //SizedBoxH30(),
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
          SizedBoxH34(),

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


