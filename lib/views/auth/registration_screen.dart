//
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:dio/dio.dart';
// import '../../services/api_services.dart';
// import '../../utils/app_color.dart';
// import '../../utils/app_text_style.dart';
// import '../../widgets/primary_textfield.dart';
//
//
// class RegistrationScrenn extends StatefulWidget {
//   final String? mobileNumber;
//
//   const RegistrationScrenn({Key? key, this.mobileNumber}) : super(key: key);
//
//   @override
//   State<RegistrationScrenn> createState() => _RegistrationScrennState();
// }
//
// class _RegistrationScrennState extends State<RegistrationScrenn> {
//
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController referralController = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void setState(VoidCallback fn) {}
//   bool obscurePassword = true;
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: ColorUtils.appBgColor,
//       child: SafeArea(
//         child: Scaffold(
//           body: Container(
//             height: double.maxFinite,
//             color: ColorUtils.whiteColor,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Image.asset(
//                     "asset/images/logo.png",
//                     scale: 2,
//                   ),
//                   SizedBox(
//                     height: 2.h,
//                   ),
//                   Container(
//                     child: Text(
//                       "Registration Here",
//                       style: FontTextStyle.poppinsS14W7BlackColor,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(30.0),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           SizedBox(height: 3.h),
//                           CustomTextField(
//                             prefixIcon: const Icon(Icons.phone),
//                             hintName: "${widget.mobileNumber}",
//                             // fieldController: phoneController,
//                             keyboard: TextInputType.phone,
//                             readonly: true,
//                             maxLines: 1,
//                             textInputAction: TextInputAction.done,
//                           ),
//                           SizedBox(
//                             height: 3.h,
//                           ),
//                           // CustomTextField(
//                           //   suffixIcon: GestureDetector(
//                           //       onTap: () {
//                           //         setState(() {
//                           //           obscurePassword = !obscurePassword;
//                           //         });
//                           //       },
//                           //       child: obscurePassword
//                           //           ? const Icon(Icons.visibility_off)
//                           //           : const Icon(Icons.visibility)),
//                           //   obscureText: obscurePassword,
//                           //   prefixIcon: const Icon(Icons.password),
//                           //   fieldController: passwordController,
//                           //   fieldName: "Password",
//                           //   hintName: " Password",
//                           //   keyboard: TextInputType.visiblePassword,
//                           //   maxLines: 1,
//                           //   textInputAction: TextInputAction.done,
//                           //   validator: (str) {
//                           //     if (str!.isEmpty) {
//                           //       return '* Is Required';
//                           //     }
//                           //     return null;
//                           //   },
//                           // ),
//                           CustomTextField(
//                             suffixIcon: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     obscurePassword = !obscurePassword;
//                                   });
//                                 },
//                                 child: obscurePassword
//                                     ? const Icon(Icons.visibility_off)
//                                     : const Icon(Icons.visibility)),
//                             obscureText: obscurePassword,
//                             prefixIcon: const Icon(Icons.password),
//                             fieldController: passwordController,
//                             fieldName: "Password",
//                             hintName: " Password",
//                             keyboard: TextInputType.visiblePassword,
//                             maxLines: 1,
//                             textInputAction: TextInputAction.done,
//                             validator: (str) {
//                               if (str!.isEmpty) {
//                                 return '* Is Required';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 3.h),
//                           CustomTextField(
//                             prefixIcon: const Icon(Icons.people),
//                             hintName: "Enter Referral Code",
//                             fieldController: referralController,
//                             keyboard: TextInputType.text,
//                             maxLines: 1,
//                             textInputAction: TextInputAction.done,
//                           ),
//                           SizedBox(height: 3.h),
//                           Center(
//                             child: SizedBox(
//                                 height: 50, //height of button
//                                 width: double.infinity, //width of button
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     primary: Colors
//                                         .lime[200], //background color of button
//                                     elevation: 3,
//                                     shape: RoundedRectangleBorder(
//                                       //to set border radius to button
//                                         borderRadius:
//                                         BorderRadius.circular(20)),
//                                   ),
//                                   onPressed: () async {
//                                     // if (_formKey.currentState!.validate()) {
//                                     //   ApiService()
//                                     //       .addAccount(context, data: data());
//                                     // }
//                                   },
//                                   child: Text(
//                                     "Sign Up",
//                                     style: FontTextStyle.poppinsS14W7BlackColor,
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   FormData data() {
//     return FormData.fromMap({
//       "referal_code": referralController.text.trim(),
//       "phone": widget.mobileNumber,
//       "password": passwordController.text.trim()
//     });
//   }
// }
