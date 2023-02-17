import 'dart:io';

import 'package:ac_tech/views/dashboard/video_player_screen.dart';
import 'package:ac_tech/views/dashboard/home_screen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../model/course_categoryid_model.dart';
import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_preferences.dart';
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
  final OtpArguments? arguments;
  const CourseDetailsScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  List<Course> getAllCourseDetails=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callApi();
  }


  Future<void> callApi() async {

    FormData data() {
      return FormData.fromMap({
        "cc_id": widget.arguments?.ccId,
      });
    }
    ApiService().categoryById(context,data: data()).then((value){

      setState(() {
        getAllCourseDetails=value.course!;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScroll(
          children: [
            SizedBoxH10(),
            Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image:  NetworkImage("https://www.actechindia.org/uploads/${widget.arguments?.ccImg}"),
                      fit: BoxFit.cover,
                    ),
                  ),
              height: Sizes.s200.h,

              ),
            SizedBoxH34(),
            Align(
                alignment: Alignment.topLeft,
                child: appText("${widget.arguments?.ccCourseName}",style: AppTextStyle.title)
            ),
            SizedBoxH10(),
            SizedBoxH30(),
            Row(
              children:[Text("${getAllCourseDetails.length.toString()} Lessons",style: AppTextStyle.alertSubtitle)],
            ),
            SizedBoxH10(),
            Container(
              height: Sizes.s320,
              child: SingleChildScrollView(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: getAllCourseDetails.length,
                  itemBuilder: (context, inx) {
                    return CoursesListContainer(
                       name: getAllCourseDetails[inx].cvlName ?? "",
                       minutes: "20 Minutes",
                      url: getAllCourseDetails[inx].cvlVideoUrl ?? "",
                      chapterName: getAllCourseDetails[inx].ccfvName ?? "",
                      chapterPdf: getAllCourseDetails[inx].cvlCoursePdf  ?? "",
                      desc: getAllCourseDetails[inx].cvlDesc  ?? "",
                    );
                  },
                ),
              ),
            ),
            //Container

          ],
        ),
        appBar: SecondaryAppBar(
          title: "${widget.arguments?.ccCourseName}",
          isLeading: true,
          leadingIcon: Icons.arrow_back,
        )
    );

  }

  Widget CoursesListContainer({
    required String name,
    required String minutes,
    required String url,
    required String chapterName,
    required String chapterPdf,
    required String desc,
  }){
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
                                image:  NetworkImage("https://www.actechindia.org/uploads/${widget.arguments?.ccImg}"),
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
                          height: 90,
                          width: 35,
                          child: GestureDetector(
                              onTap:(){
                                Navigator.pushNamed(context, Routs.videoPlayer,
                                    arguments: OtpArguments(
                                      ccUrl: url,
                                      ccChapterName: name,
                                      ccCourseName: chapterName,
                                      ccChapterPdf: chapterPdf,
                                      ccDesc: desc,
                                    ));
                                //  clearField();
                              },
                              child: Image.asset(AppAsset.playButton)),
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

