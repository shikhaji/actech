import 'package:ac_tech/model/course_category_model.dart';
import 'package:ac_tech/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Course> getAllCourses=[];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _search = TextEditingController();



  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getAllCourses(context).then((value){
      setState(() {
        getAllCourses=value.course!;
      });
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

            Align(
              alignment: Alignment.topLeft,
                child: Text("All Courses ",style: AppTextStyle.alertSubtitle)),

            SizedBoxH10(),
            Container(
              height: Sizes.s600,
              child:SingleChildScrollView(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: getAllCourses.length,
                  itemBuilder: (context, inx) {
                    return CoursesListContainer(
                        name:getAllCourses[inx].ccName ?? "",
                        lessons: '10 Lessons',
                        ratings: "3.4",
                        amount: getAllCourses[inx].ccCommision ?? "",);
                  },
                ),
              ),
            ),
            //Container

          ],
        ),
        appBar: SecondaryAppBar(
          title: "All Courses",
          isLeading: true,
          leadingIcon: Icons.menu,
          onBackPressed: () {
            openDrawer();
          },
        ));
  }
  Widget CoursesListContainer(
  {required String name,
  required String lessons,
  required String ratings,
  required String amount,}
      ){
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
                                  image: AssetImage(AppAsset.flutter),
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
                                        .copyWith(fontSize: Sizes.s14.h),
                                ),
                                SizedBoxH6(),
                                appText(lessons,
                                    style: AppTextStyle.alertSubtitle
                                        .copyWith(fontSize: Sizes.s14.h)),
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
                                            .copyWith(fontSize: Sizes.s14.h)),
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
                        SizedBox(
                          height: 30,
                          width: 20,
                          child: Image.asset(AppAsset.bookmark),
                        ),
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