import 'package:ac_tech/model/course_category_model.dart';
import 'package:ac_tech/routes/app_routes.dart';
import 'package:ac_tech/utils/app_text_style.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/constant.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/scrollview.dart';
import 'main_home_screen.dart';

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
  List<Course> getAllCourses=[];
  List<Course> allCourseListRes = [];
  bool _isSearching = false;
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
  void initState() {
    super.initState();

    callApi();
    callCourseApi();
  }

  Future<void> callApi() async {

    ApiService().slider(context).then((value) {
      setState(() {
        sliderImageList = value.detail! ;
      });
      print("slider images ;=${sliderImageList[0].bannerImage}");
    });

  }
  Future<void> callCourseApi()async {
    String? id = await Preferances.getString("userId");
    FormData data() {
      return FormData.fromMap({
        "loginid":id?.replaceAll('"', '').replaceAll('"', '').toString(),
        "status" :"0",
      });
    }
    GetAllCourseCategory? _getAllCourseCategory= await ApiService().getAllCourses(context,data: data());

    if(_getAllCourseCategory != null){

      getAllCourses = _getAllCourseCategory.course!
          .map((e) => Course.fromJson(e.toJson()))
          .toList();
      allCourseListRes = _getAllCourseCategory.course!
          .map((e) => Course.fromJson(e.toJson()))
          .toList();
      setState(() {});
    }
  }

  Future<void> _onSearchHandler(String qurey) async {
    if (qurey.isNotEmpty) {
      _isSearching = true;
      getAllCourses = _isSearching ? searchCourse(qurey) : getAllCourses;
    } else {
      getAllCourses.clear();
      getAllCourses = allCourseListRes;
      _isSearching = false;
    }
    setState(() {});
  }

  List<Course> searchCourse(String qurey) {
    return allCourseListRes
        .where((e) => e.ccfvName!.toLowerCase().contains(qurey.toLowerCase()))
        .toList();
  }

  String? paymentId;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    //Paymnet sucess api call;
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
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
                TextButton(onPressed: (){
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainHomeScreen(index: 1,),), (route) => false);
                }, child: Text("See All",style: AppTextStyle.subTitle.copyWith(color: AppColor.primaryColor),))
              ],
            ),
            SizedBoxH10(),
            GestureDetector(
              onTap: (){
              },
              child: Container(
                height: Sizes.s350,
                child:SingleChildScrollView(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: getAllCourses.length,
                    itemBuilder: (context, inx) {
                      return CoursesListContainer(
                        image:getAllCourses[inx].ccfvCourseImage ?? "",
                        name:getAllCourses[inx].ccfvName ?? "",
                        lessons: "${getAllCourses[inx].ccfvTotalLessons ?? ""} Lessons",
                        displayAmount: "₹${getAllCourses[inx].ccfvCommision ?? ""}",
                        ccid: getAllCourses[inx].ccfvId ?? "",
                        ccstatus: getAllCourses[inx].ccfvStatus ?? "",
                        ccIntroVideo: getAllCourses[inx].ccfvUrl ?? "",
                        amount: "${getAllCourses[inx].ccfvCommision ?? ""}",
                      );
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


  Widget CoursesListContainer(
      {required String image,
        required String name,
        required String lessons,
        required String amount,
        required String ccid,
        required String ccstatus,
        required String displayAmount,
        required String ccIntroVideo,
      }
      ){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Routs.introductionVideo,
                arguments: OtpArguments(ccUrl: ccIntroVideo)
            );
          },
          child: Container(
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

                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              height: Sizes.s80.h,
                              width: Sizes.s120.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image:  NetworkImage("https://www.actechindia.org/uploads/${image}"),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            SizedBoxW8(),
                            Flexible(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 6,
                                    style: AppTextStyle.alertSubtitle
                                        .copyWith(fontSize: Sizes.s14.h),
                                  ),
                                  SizedBoxH8(),
                                  Text(lessons,
                                      style: AppTextStyle.alertSubtitle)


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          SizedBoxH8(),
                          appText(displayAmount,
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

