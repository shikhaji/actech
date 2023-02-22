import 'dart:io';
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
    return LayoutBuilder(

      builder: ( BuildContext context, BoxConstraints constraints ) {

        return YoutubePlayer(
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
        );
      },

    );
  }

}


