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

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with ValidationMixin {
  final TextEditingController _password = TextEditingController();
  bool obscurePassword = true;
  bool obscurePassword1 = true;
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
                appText("Reset Password", style: AppTextStyle.title),
                SizedBoxH6(),
                appText("Enter new password here",
                    style: AppTextStyle.subTitle),
                SizedBoxH28(),
                appText("Password", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _password,
                  hintText: "Enter password",
                  validator: passwordValidator,
                  prefix: const Icon(Icons.password),
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      child: obscurePassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  obscureText: obscurePassword,
                ),
                SizedBoxH8(),
                appText("Confirm Password", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _password,
                  hintText: "Enter confirm password",
                  validator: passwordValidator,
                  prefix: const Icon(Icons.password),
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscurePassword1 = !obscurePassword1;
                        });
                      },
                      child: obscurePassword1
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  obscureText: obscurePassword1,
                ),
                SizedBoxH8(),
                PrimaryButton(
                    lable: "Reset",
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>OtpVerificationScreen()));
                    }),
              ],
            ),
          )),
    );
  }
}
