import 'package:ac_tech/model/course_category_model.dart';
import 'package:ac_tech/services/api_services.dart';
import 'package:ac_tech/utils/function.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
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

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Course> getAllCourses=[];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  late var _razorpay;
  String courseId ="";
  String loginId ="";

  List<Course> allCourseListRes = [];
  bool _isSearching = false;



  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginId();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    callApi();

  }

  Future<void> callApi()async {
    String? id = await Preferances.getString("userId");
    FormData data() {
      return FormData.fromMap({
        "loginid":id?.replaceAll('"', '').replaceAll('"', '').toString(),
        "status" :"0",
      });
    }
    GetAllCourseCategory? _getAllCourseCategory= await ApiService().getAllCourses(context,data: data());

    if(_getAllCourseCategory != null){

      getAllCourses = _getAllCourseCategory.course
          .map((e) => Course.fromJson(e.toJson()))
          .toList();
      allCourseListRes = _getAllCourseCategory.course
          .map((e) => Course.fromJson(e.toJson()))
          .toList();
      setState(() {});
    }
  }

  Future<void>getLoginId()async{
    String? id = await Preferances.getString("userId");
    setState(() {
      loginId="$id";
      print("LoginId:$loginId");
    });
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
        .where((e) => e.ccfvName.toLowerCase().contains(qurey.toLowerCase()))
        .toList();
  }

  String? paymentId;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    print("paymentStatus");
    print(paymentId);
    print("LoginId:${loginId?.replaceAll('"','').replaceAll('"', '').toString()}");
    print("CourseId:$courseId");
    try{
      FormData data(){
        return FormData.fromMap({"course_id":courseId,"transaction_id":paymentId,"payment_status":1,"loginid":loginId?.replaceAll('"','').replaceAll('"', '').toString()});
      }
      ApiService().addPurchase(context,data: data());
    }catch(e){
      print(e.toString());
    }
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
            PrimaryTextField(
              controller: _searchController,
              onChanged: _onSearchHandler,
              hintText: 'Search Course',
              color: AppColor.textFieldColor,
              suffix: _isSearching
                  ? InkWell(
                onTap: () {
                  _searchController.clear();
                  _isSearching = false;
                  getAllCourses.clear();
                  getAllCourses = allCourseListRes;
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
              )
                  : null,
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
                        image:getAllCourses[inx].ccfvCourseImage ?? "",
                        name:getAllCourses[inx].ccfvName ?? "",
                        lessons: "${getAllCourses[inx].ccfvTotalLessons ?? ""} Lessons",
                        displayAmount: "₹${getAllCourses[inx].ccfvCommision ?? ""}",
                        ccid: getAllCourses[inx].ccfvId ?? "",
                        ccstatus: getAllCourses[inx].ccfvStatus ?? "",
                        amount: "${getAllCourses[inx].ccfvCommision ?? ""}"
                    );
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
  {required String image,
  required String name,
  required String lessons,
  required String amount,
  required String displayAmount,
  required String ccid,
  required String ccstatus,
  }
      ){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(
                  "Payment for $name course",
                  style: AppTextStyle.alertSubtitle,
                ),
                content: Text(
                  "Amount: ${displayAmount}",
                  style: AppTextStyle.subTitle,
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(14),
                          child: const Text("Cancel"),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          courseId =ccid;
                          Navigator.pop(context);
                          var options = {
                            'key': 'rzp_test_YoriHE0YT6XVEs',
                            'amount': int.parse(amount) * 100,
                            'name': 'AC-Tech',
                            'description': 'Course Purchased',
                            'send_sms_hash': true,
                            'prefill': {
                              'contact': 'Yashil Patel',
                              'email': 'yashil@gmail.com',
                              'phone': '9979966965',
                            },
                          };
                          _razorpay.open(options);

                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(14),
                          child: const Text("Pay Now"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                        Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  appText(name,
                                      style: AppTextStyle.alertSubtitle
                                          .copyWith(fontSize: Sizes.s14.h),
                                  ),
                                  SizedBoxH8(),
                                  appText(lessons,
                                      style: AppTextStyle.alertSubtitle)


                                ],
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