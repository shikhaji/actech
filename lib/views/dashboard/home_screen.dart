import 'dart:convert';

import 'package:ac_tech/utils/app_text_style.dart';
import 'package:ac_tech/views/dashboard/course_details_screen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:sizer/sizer.dart';

import '../../model/slider_model.dart';
import '../../services/api_services.dart';
import '../../utils/app_assets.dart';
import 'package:http/http.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/constant.dart';
import '../../utils/loader.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/scrollview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  final TextEditingController _search = TextEditingController();
  int _selectedSliderIndex = 0;
  List sliderImageList = [];
  List latestNewsList = [];
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
  void initState() {
    super.initState();

    callApi();
  }

  Future<void> callApi() async {

    ApiService().slider(context).then((value) {
      setState(() {
        sliderImageList = value.detail! ;
      });
      print("slider images ;=${sliderImageList[0].bannerImage}");
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.white,
          elevation: 0,
          width: ScreenUtil().screenWidth * 0.8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Sizes.s20.r),
              bottomRight: Radius.circular(Sizes.s20.r),
            ),
          ),
          child: const DrawerWidget(),
        ),
        body: CustomScroll(
          children: [
            SizedBoxH18(),
            PrimaryTextField(
              controller: _search,
              hintText: "Search Here",
              suffix: Icon(CupertinoIcons.search),
            ),
            SizedBoxH18(),
            SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                  carouselController: buttonCarouselController,
                  itemCount: sliderImageList.length ?? 0,
                  itemBuilder: (BuildContext context, int itemIndex,
                      int pageViewIndex) =>
                      Padding(
                          padding: const EdgeInsets.only(right: 3, left: 3),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      'https://www.actechindia.org/uploads/${sliderImageList[itemIndex].bannerImage}',
                                    ),
                                    fit: BoxFit.cover)),
                          )),
                  options: CarouselOptions(
                    onPageChanged: (index, _) {
                      setState(() {
                        _selectedSliderIndex = index;
                      });
                    },
                    aspectRatio: 15 / 8,
                    viewportFraction: 1,
                    initialPage: 0,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                    const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
            SizedBoxH18(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  sliderImageList.length,
                      (index) => Indicator(
                      isActive: _selectedSliderIndex == index ? true : false),
                )
              ],
            ),
            SizedBoxH10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recommended Courses ",style: AppTextStyle.alertSubtitle),
                Text("See All",style: AppTextStyle.subTitle.copyWith(color: AppColor.primaryColor),)
              ],
            ),
            SizedBoxH10(),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CourseDetailsScreen()),
                );
              },
              child: Container(
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
                          // "https://mobignosis.com/wp-content/uploads/2019/10/Flutter.png",
                          "10 Lessons",
                          "4.5",
                          "₹999");
                    },
                  ),
                ),
              ),
            ),
            //Container

          ],
        ),
        appBar: SecondaryAppBar(
            title: "Home",
            isLeading: true,
            leadingIcon: Icons.menu,
            onBackPressed: () {
              openDrawer();
            },
            )
    );

  }
  Widget CoursesListContainer(String name,String lessons,String ratings,String amount){
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
                                 image: AssetImage(AppAsset.android),
                                 fit: BoxFit.fitHeight,
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
                              appText(lessons,
                                  style: AppTextStyle.alertSubtitle
                                      .copyWith(fontSize: Sizes.s16.h)),
                              SizedBoxH6(),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: Image.asset(AppAsset.star),
                                  ),
                                  SizedBoxW6(),
                                  appText(ratings,
                                      style: AppTextStyle.alertSubtitle
                                          .copyWith(fontSize: Sizes.s16.h)),
                                ],
                              ),
                              SizedBoxH6(),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        SizedBoxH8(),
                        appText(amount,
                            style: AppTextStyle.headingTextTile
                                .copyWith(fontSize: Sizes.s18.h,color: AppColor.primaryColor)),
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

