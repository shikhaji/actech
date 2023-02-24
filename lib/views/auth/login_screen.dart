import 'package:ac_tech/utils/app_assets.dart';
import 'package:ac_tech/views/auth/forgot_password_screen.dart';
import 'package:ac_tech/views/auth/mobile_verification_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../services/api_services.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../utils/validation_mixin.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/scrollview.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
                SizedBoxH34(),
                SizedBoxH34(),
                Center(
                  child: Image.asset(
                    AppAsset.mainLogoImage,
                    height: 20.h,
                  ),
                ),
                SizedBoxH28(),
                SizedBoxH28(),
                appText("Login", style: AppTextStyle.title),
                SizedBoxH6(),
                appText("Please login with phone number and password",
                    style: AppTextStyle.subTitle),
                SizedBoxH28(),
                appText("Phone number", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _phone,
                  hintText: "Enter phone number",
                  validator: mobileNumberValidator,
                  prefix: const Icon(Icons.phone),
                  keyboardInputType: TextInputType.phone,
                ),
                SizedBoxH10(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>ForgotPasswordScreen()));
                        },
                        child:
                        appText("Forgot password?", style: AppTextStyle.lable))
                  ],
                ),
                SizedBoxH8(),
                PrimaryButton(
                    lable: "Login",
                    onPressed: () async{

                      if (_formKey.currentState!.validate()) {
                          FormData data() {
                          return FormData.fromMap({
                          "user_id": _phone.text.trim(),
                          "password": _password.text.trim(),
                          });
                          }
                          ApiService().login(context,data:data());

                          }
                    }),
                SizedBoxH18(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appText(
                        "You don’t have an account? ",
                        style: AppTextStyle.subTitle,
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(
                            context,
                              MaterialPageRoute(
                                  builder: (context) =>MobileVerificationScreen()));
                                //  clearField();
                                },
                        child: appText(
                          "Sign Up",
                          style: AppTextStyle.redTextStyle
                              .copyWith(color: AppColor.primaryLightColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
