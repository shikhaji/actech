//
//
// import 'package:ac_tech/views/auth/otp_verification_screen.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../Utils/app_color.dart';
// import '../../services/api_services.dart';
//
// import '../../utils/app_text_style.dart';
// import '../../utils/loader.dart';
// import '../../widgets/primary_button.dart';
// import '../../widgets/primary_textfield.dart';
// import 'login_screen.dart';
//
// class ForgotPasswordNumberScreen extends StatefulWidget {
//   const ForgotPasswordNumberScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ForgotPasswordNumberScreen> createState() => _ForgotPasswordNumberScreenState();
//
// }
//
// class _ForgotPasswordNumberScreenState extends State<ForgotPasswordNumberScreen> {
//   TextEditingController phone = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
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
//                     child: Text("Forgot Password",
//                         style: FontTextStyle.poppinsS18W7BlackColor),
//                   ),
//                   // SizedBox(
//                   //   height: 2.h,
//                   // ),
//                   // Center(child: Text("Enter your Phone Number",style: FontTextStyle.poppinsS10HintColor)),
//                   // Center(child: Text("associated to your account !",style: FontTextStyle.poppinsS10HintColor)),
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
//                           CustomTextField(
//                             prefixIcon: Icon(Icons.phone),
//                             fieldName: "Mobile Number",
//                             hintName: "Enter Your Mobile Number",
//                             // fieldController: _phoneController,
//                             keyboard: TextInputType.number,
//                             validator: (str) {
//                               if (str!.isEmpty) {
//
//                                 return '* Is Required';
//
//                               } else if (str.length != 10) {
//                                 return '* Enter valid Mobile Number';
//                               }
//
//                               return null;
//                             },
//                           ),
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
//                                         builder: (context) => OtpVerificationScreen()));
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
//
//   FormData data() {
//     return FormData.fromMap({
//       "mobile": phone.text.trim(),
//     });
//   }
// }
