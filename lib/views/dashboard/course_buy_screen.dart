

import 'package:ac_tech/widgets/primary_button.dart';
import 'package:ac_tech/widgets/primary_padding.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/course_category_model.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/scrollview.dart';

class CourseBuyScreen extends StatefulWidget {
  final OtpArguments arguments;

  const CourseBuyScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  State<CourseBuyScreen> createState() => _CourseBuyScreenState();
}



class _CourseBuyScreenState extends State<CourseBuyScreen> {
  List<Course> getAllCourseDetails = [];
  late var _razorpay;
  String loginId ="";
  String courseId ="";
  CarouselController buttonCarouselController = CarouselController();

  //VIDEO PLAYER
  late var videoURL = "${widget.arguments.ccUrl.toString()}";

  late YoutubePlayerController _controller;
  double? _progress;


  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        loop: false,
        hideThumbnail: true,
      ),
    );
    super.initState();
    getLoginId();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


  }
  Future<void>getLoginId()async{
    String? id = await Preferances.getString("userId");
    setState(() {
      loginId="$id";
      print("LoginId:$loginId");
    });
  }

  String? paymentId;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    print("paymentStatus");
    print(paymentId);
    print("LoginId:${loginId.replaceAll('"','').replaceAll('"', '').toString()}");
    print("CourseId:$courseId");
    try{
      FormData data(){
        return FormData.fromMap({"course_id":widget.arguments.ccId,"transaction_id":paymentId,"payment_status":1,"loginid":loginId.replaceAll('"','').replaceAll('"', '').toString()});
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBoxH28(),

            PrimaryPadding(
              child: Column(
                children: [
                 Container(

                   child:  YoutubePlayer(
                     controller: _controller,
                     showVideoProgressIndicator: true,
                     onReady: () => debugPrint("Ready"),
                     bottomActions: [
                       CurrentPosition(),
                       ProgressBar(
                         isExpanded: true,

                         colors: const ProgressBarColors(
                           playedColor: AppColor.primaryColor,
                           handleColor: AppColor.primaryLightColor,
                         ),
                       ),
                       RemainingDuration(),
                       PlaybackSpeedButton(),
                     ],
                   ),
                 ),
                  SizedBoxH20(),
                  PrimaryButton(lable: "Enroll for ₹${widget.arguments.ccAmount}",
                  onPressed: () async {
                      courseId ="${widget.arguments.ccId}";


                      var options = {
                        'key': 'rzp_test_YoriHE0YT6XVEs',
                        'amount': int.parse("${widget.arguments.ccAmount}") * 100,
                        'name': 'AC-Tech',
                        'description': 'Course Purchased',
                        'send_sms_hash': true,
                        'prefill': {
                          'contact': '',
                          'email': '',
                          'phone': '',
                        },
                      };
                      _razorpay.open(options);

                    },),
                ],
              ),
            ),
            SizedBoxH10(),

            SizedBoxH10(),
            Expanded(
              child: PrimaryPadding(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.textFieldColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                  ),
                  child: Flexible(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBoxH14(),
                        PrimaryPadding(
                          child: Text("Course : ${widget.arguments.ccCourseName}",
                              style: AppTextStyle.title,overflow: TextOverflow.ellipsis,maxLines: 10,),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBoxH18(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: PrimaryPadding(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child:  Text(
                                    "Course Description : ${widget.arguments?.ccDesc} ",
                                    style: AppTextStyle.alertSubtitle1,overflow: TextOverflow.ellipsis,maxLines: 50,),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),



          ],
        ),



      ),

      appBar: SecondaryAppBar(
        title: "${widget.arguments?.ccCourseName} Details",
        isLeading: true,
        leadingIcon: Icons.arrow_back,
      ),
    );
  }


}


