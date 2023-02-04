
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../services/shared_preference.dart';
import '../../utils/color_utils.dart';
import '../../utils/font_utils.dart';
import '../../widgets/custom_btn.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: SafeArea(
        child: Scaffold(
          appBar:AppBar(
            backgroundColor: ColorUtils.whiteColor,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("Login",style: TextStyle(color:ColorUtils.blackColor)),

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text("Login to your Account",
                          style: FontTextStyle.poppinsS20W7BlackColor),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [

                          CustomTextField(
                            prefixIcon: Icon(Icons.email_outlined),
                            fieldName: "Email",
                            hintName: "Enter Your Email Id",
                            // fieldController: _emailController,
                            keyboard: TextInputType.emailAddress,
                            validator: (str) {
                              if (str!.isEmpty) {
                                return '* Is Required';
                              } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(str)) {
                                return '* Enter valid email-ID';
                              }
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CustomTextField(  prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector
                              (onTap: (){
                              setState(() {
                                obscurePassword=! obscurePassword;
                              });

                            },
                                child: obscurePassword? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                            obscureText: obscurePassword,
                            maxLines: 1,
                            fieldName: "Password",
                            hintName: "Enter Your Password",
                            keyboard: TextInputType.visiblePassword,
                            // fieldController: _passwordController,
                            validator: (str) {
                              if (str!.isEmpty) {

                                return '* Is Required';

                              } else if (str.trim().length < 8) {
                                return "Password must be least 8 character long!";
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                                //  clearField();

                              }

                            },
                            buttonText: "SIGN UP",
                            textStyle: FontTextStyle.poppinsS14W4WhiteColor,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  child: Text("Forgot Password?",
                                      style: FontTextStyle.poppinsS14W4BlackColor),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const LoginScreen()));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

        ),


      ),
    );
  }
  // FormData data() {
  //   return FormData.fromMap({"user_id": phoneController.text.trim(),"password":passwordController.text.trim()});
  // }
}
