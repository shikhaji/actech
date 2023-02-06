import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../services/api_services.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/image_utils.dart';
import '../../utils/validation_mixin.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/scrollview.dart';

class SignUpScreen extends StatefulWidget {
  // final OtpArguments? arguments;
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with ValidationMixin {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _referCode = TextEditingController();
  final TextEditingController _categories = TextEditingController();
  bool obscurePassword = true;
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
                Center(
                  child: Image.asset(
                    ImageUtils.splashImage,
                    height: 20.h,
                  ),
                ),
                SizedBoxH28(),
                appText("Sign Up", style: AppTextStyle.title),
                SizedBoxH6(),
                appText("Fill your details to continue",
                    style: AppTextStyle.subTitle),
                SizedBoxH28(),
                appText("Name", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _name,
                  prefix: const Icon(Icons.perm_identity),
                  hintText: "Enter your name",
                ),
                SizedBoxH10(),
                appText("Phone number", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _phone,
                  keyboardInputType: TextInputType.phone,
                  validator: mobileNumberValidator,
                  readOnly: true,
                  prefix: const Icon(Icons.phone),
                  // hintText: "${widget.arguments?.phoneNumber}",
                ),
                SizedBoxH10(),
                appText("Password", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  hintText: "Enter password",
                  controller: _password,
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
                SizedBoxH10(),
                appText("Refer Code", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _referCode,
                  hintText: "Enter refer code",
                ),
                SizedBoxH8(),
                PrimaryButton(
                    lable: "Sign Up",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {


                      }
                    }),
              ],
            ),
          )),
    );
  }
}
