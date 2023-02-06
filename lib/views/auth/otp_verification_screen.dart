// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../Utils/app_color.dart';
// import '../../utils/app_text_style.dart';
// import '../../widgets/primary_button.dart';
// import '../../widgets/primary_textfield.dart';
// import 'login_screen.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
//
// class OtpVerificationScreen extends StatefulWidget {
//   const OtpVerificationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
// }
//
// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blueGrey,
//       child: SafeArea(
//         child: Scaffold(
//           appBar:AppBar(
//             backgroundColor: ColorUtils.whiteColor,
//             elevation: 0,
//             centerTitle: true,
//             leading: IconButton(
//               icon: const Icon(Icons.close, color: Colors.black),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             // title: Text("Login",style: TextStyle(color:ColorUtils.blackColor)),
//
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(2.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height:10.h,
//                   ),
//                   Center(
//                     child: Text("OTP Verification",
//                         style: FontTextStyle.poppinsS18W7BlackColor),
//                   ),
//                   SizedBox(
//                     height: 2.h,
//                   ),
//                   Center(child: Text("Enter 4 digit code sent to your phone number",style: FontTextStyle.poppinsS10HintColor)),
//                   Center(child: Text("7486981727",style: FontTextStyle.poppinsS10HintColor)),
//                   SizedBox(
//                     height: 2.h,
//                   ),
//                   OTPTextField(
//                     length: 4,
//                     width: MediaQuery.of(context).size.width,
//                     fieldWidth: 30,
//                     style: TextStyle(
//                         fontSize: 25
//                     ),
//                     textFieldAlignment: MainAxisAlignment.spaceAround,
//                     fieldStyle: FieldStyle.underline,
//                     onCompleted: (pin) {
//                       print("Completed: " + pin);
//                     },
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Form(
//                     key: _formKey,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 5.w),
//                       child: Column(
//                         children: [
//
//
//
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           CustomButton(
//                             onTap: () {
//                               if (_formKey.currentState!.validate()) {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => LoginScreen()));
//                                 //  clearField();
//
//                               }
//
//                             },
//                             buttonText: "Send the code",
//                             textStyle: FontTextStyle.montserratS12W4WhiteColor,
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//
//         ),
//
//
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../utils/function.dart';
import '../../utils/image_utils.dart';
import '../../utils/validation_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/scrollview.dart';

class OtpVerificationScreen extends StatefulWidget {


  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with ValidationMixin {
  TextEditingController _controller = TextEditingController(text: "");
  int pinLength = 6;
  int _seconds = -1;
  Timer? _timer;
  String _verificationId = '';

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH34(),
            SizedBoxH34(),
            SizedBoxH34(),
            Center(
              child: Image.asset(
                ImageUtils.splashImage,
                height: 20.h,
              ),),
            SizedBoxH28(),
            SizedBoxH28(),
            appText("OTP Verification", style: AppTextStyle.title),
            SizedBoxH6(),
            appText(
                "Enter 6 digit code sent to your phone number",
                style: AppTextStyle.subTitle),
            SizedBoxH28(),
            appText("Enter OTP", style: AppTextStyle.lable),
            SizedBoxH8(),
            PinCodeTextField(
              autofocus: false,
              controller: _controller,
              hideCharacter: false,
              highlight: false,
              highlightColor: Theme.of(context).cardColor,
              defaultBorderColor: Theme.of(context).cardColor,
              hasTextBorderColor: Theme.of(context).cardColor,
              highlightPinBoxColor: Theme.of(context).cardColor,
              pinBoxColor: AppColor.textFieldColor,
              maxLength: pinLength,
              onDone: (text) {
                _controller.text = text;
              },
              pinBoxWidth: 45,
              pinBoxHeight: 55,
              hasUnderline: false,
              pinBoxRadius: 10,
              wrapAlignment: WrapAlignment.spaceAround,
              pinBoxDecoration:
              ProvidedPinBoxDecoration.defaultPinBoxDecoration,
              pinTextStyle: const TextStyle(fontSize: 22.0),
              pinTextAnimatedSwitcherTransition:
              ProvidedPinBoxTextAnimation.scalingTransition,
              pinTextAnimatedSwitcherDuration:
              const Duration(milliseconds: 300),
              highlightAnimationBeginColor: Theme.of(context).cardColor,
              highlightAnimationEndColor: Theme.of(context).cardColor,
              keyboardType: TextInputType.number,
            ),
            SizedBoxH20(),
            PrimaryButton(
                lable: "Verify OTP",
                onPressed: () async {}),
          ],
        ),
      ),
    );
  }

//   Future<void> sendCode() async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: "${"+91"}${widget.arguments?.phoneNumber}",
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       verificationFailed: (FirebaseAuthException e) {
//         if (e.code == 'web-context-cancelled') {
//           throw e.message ?? 'Error';
//         } else {
//           throw e.message ?? 'Error';
//         }
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         _verificationId = verificationId;
//         setState(() {});
//         _startTimer();
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         _verificationId = verificationId;
//         print("verificationId:=$verificationId");
//         print("_verificationId_verificationId:=$_verificationId");
//
//         setState(() {});
//       },
//     );
//   }
//
//   Future _verify(String smsCode) async {
//     Loader.showLoader();
//     try {
//       final PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: smsCode,
//       );
//
//       UserCredential credential =
//       await FirebaseAuth.instance.signInWithCredential(authCredential);
//       if (widget.arguments?.otpStatus == 1) {
//         CommonFunctions.toast("otp verify successfully !!");
//         Navigator.pushNamed(context, Routs.resetPassword,arguments:
//         OtpArguments(phoneNumber: widget.arguments?.phoneNumber));
//
//       } else {
//         CommonFunctions.toast("otp verify successfully !!");
//         Navigator.pushNamed(context, Routs.signUp,
//             arguments:
//             OtpArguments(phoneNumber: widget.arguments?.phoneNumber));
//       }
//
//       Loader.hideLoader();
//       return AuthResult(status: true, user: credential.user);
//     } on FirebaseAuthException catch (e) {
//       Loader.hideLoader();
//       debugPrint('inside catch : ${e.message}');
//       AuthResult result = AuthResult(status: false, message: e.message);
//
//       switch (e.code) {
//         case 'invalid-verification-code':
//           result.message = 'Your SMS code is invalid.';
//           break;
//         case 'provider-already-linked':
//           result.message = 'This phone number is already registered.';
//           break;
//         default:
//       }
//       if (result.message != null) {
//         _controller.clear();
//         CommonFunctions.toast(result.message!);
//       }
//       return AuthResult(status: false);
//     }
//     }
 }