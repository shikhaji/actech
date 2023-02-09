import 'dart:io';

import 'package:ac_tech/views/dashboard/home_screen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/constant.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/scrollview.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  final TextEditingController _search = TextEditingController();
  int _selectedSliderIndex = 0;
  List sliderImageList = [];
  List latestNewsList = [];

  //VIDEO PLAYER
  late VideoPlayerController _controller;
  final File newFile = File('File');
  int _currentIndex= 0;
  void _playVideo({required File file}){
    _controller =VideoPlayerController.asset(AppAsset.sampleVideo)
    ..addListener(() => setState(() {}))
    ..setLooping(true)
    ..initialize().then((value) => _controller.play());
  }

  // String _videoDuration(Duration duration){
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final hours = twoDigits(duration.inHours);
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //
  //   return[
  //     if (duration.inHours > 0) hours,
  //     minutes,
  //     seconds,
  //   ].join(':');
  // }
  @override
  void initState() {
    super.initState();
    _playVideo(file :newFile);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,

        body: CustomScroll(
          children: [
            SizedBoxH10(),
            Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15),
                  //   image: DecorationImage(
                  //     image: AssetImage(AppAsset.android),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
              height: Sizes.s200.h,
              child:VideoPlayer(_controller),

              ),
            SizedBoxH34(),
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 50,
                  child: Image.asset(AppAsset.view),
                ),
                appText("2651"),
                SizedBox(
                  height: 20,
                  width: 50,
                  child: Image.asset(AppAsset.star),
                ),
                appText("4.5"),
              ],
            ),
            SizedBoxH20(),
            Align(
                alignment: Alignment.topLeft,
                child: appText("Flutter Beginners",style: AppTextStyle.title)
            ),
            SizedBoxH10(),
            Text("Lorem ipsum dolor sit amet. Ad culpa quia aut facilis accusantium autdolores quisquam aut sunt voluptatibus et Quis similique. Ex magni eiuseum harum ipsa hic rerum accusamus aut sint molestias. Aut consecteturtotam sit nihil vitae ex voluptatibus accusantium ut suscipit quae aut iureeaque et ",style: AppTextStyle.subTitle),
            SizedBoxH30(),
            Row(
              children:[Text("5 Lessons (8 hours)",style: AppTextStyle.alertSubtitle)],
            ),
            SizedBoxH10(),
            Container(
              height: Sizes.s320,
              child: SingleChildScrollView(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, inx) {
                    return CoursesListContainer(
                        "UI Design",
                        "20 Minutes");
                  },
                ),
              ),
            ),
            //Container

          ],
        ),
        appBar: SecondaryAppBar(
          title: "UI Design",
          isLeading: true,
          leadingIcon: Icons.arrow_back,
        )
    );

  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  Widget CoursesListContainer(String name,String minutes){
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.textFieldColor,
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      child: Row(
                        children: [
                          Container(
                            height: Sizes.s80.h,
                            width: Sizes.s120.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(AppAsset.flutter),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          SizedBoxW8(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appText(name,
                                  style: AppTextStyle.alertSubtitle
                                      .copyWith(fontSize: Sizes.s16.h)),
                              SizedBoxH6(),
                              appText(minutes,
                                  style: AppTextStyle.alertSubtitle
                                      .copyWith(fontSize: Sizes.s16.h)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 25,
                          child: Image.asset(AppAsset.playButton),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBoxH10(),
      ],
    );


  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      height: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      width: isActive ? 10.0 : 10.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.black,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black, width: 2.0)),
    );
  }
}
