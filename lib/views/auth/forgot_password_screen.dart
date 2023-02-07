import 'package:ac_tech/views/auth/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../utils/validation_mixin.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/scrollview.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with ValidationMixin {
  final TextEditingController _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
          child: Form(
            key: _formKey,
            child: CustomScroll(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxH34(),
                SizedBoxH34(),
                SizedBoxH34(),
                Center(
                  child: Image.asset(
                    AppAsset.splashImage,
                    height: 20.h,
                  ),
                ),
                SizedBoxH28(),
                SizedBoxH28(),
                appText("Forgot Password", style: AppTextStyle.title),
                SizedBoxH6(),
                appText("Enter registered phone number and we will send you",
                    style: AppTextStyle.subTitle),
                appText("an OTP",
                    style: AppTextStyle.subTitle),
                SizedBoxH28(),
                appText("Phone number", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _phone,
                  validator: mobileNumberValidator,
                  keyboardInputType: TextInputType.phone,
                  prefix: const Icon(Icons.phone),
                  hintText: "Enter phone number",
                ),
                SizedBoxH8(),
                PrimaryButton(
                    lable: "Send OTP",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>ResetPasswordScreen()));
                    }),
                SizedBoxH18(),

              ],
            ),
          )),
    );
  }
}
