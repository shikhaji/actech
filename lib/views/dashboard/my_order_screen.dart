import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/my_order_list_model.dart';
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
import '../../widgets/scrollview.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List<Course> myOrderList=[];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callApi();
  }

  Future<void> callApi() async {
    String? id = await Preferances.getString("userId");

    FormData data() {
      return FormData.fromMap({
        "login_id":id?.replaceAll('"', '').replaceAll('"', '').toString(),
      });
    }
    print("login id $id");
    ApiService().myOrderList(context,data: data()).then((value){
      setState(() {
        myOrderList=value.course!;
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
            SizedBoxH10(),

            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: myOrderList.length,
              itemBuilder: (context, inx) {
                return CoursesListContainer(
                    image: myOrderList[inx].courseImage ?? "",
                    name:myOrderList[inx].ccName ?? "",
                    lessons: myOrderList[inx].ccTotalLessons ?? "",
                    amount:"₹${myOrderList[inx].ccCommision ?? ""}",);
              },
            ),
          ],
        ),
        appBar: SecondaryAppBar(
          title: "My Order",
          isLeading: true,
          leadingIcon: Icons.menu,
          onBackPressed: () {
            openDrawer();
          },
        ));
  }
  Widget CoursesListContainer({
    required String image,
    required String name,
    required String lessons,
    required String amount,
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
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image:  NetworkImage("https://www.actechindia.org/uploads/${image}"),
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

