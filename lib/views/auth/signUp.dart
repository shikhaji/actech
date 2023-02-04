
import 'package:ac_tech/Utils/color_utils.dart';
import 'package:ac_tech/views/auth/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../services/api_services.dart';
import '../../utils/font_utils.dart';
import '../../utils/loader.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_btn.dart';
import '../../widgets/custom_text_field.dart';
import 'otp_verification_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool obscurePassword=true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            title: Text("Sign Up",style: TextStyle(color:ColorUtils.blackColor)),

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
                      child: Text("Create your Account",
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
                          const CustomTextField(
                            fieldName: "Full Name",
                            hintName: "",
                            // fieldController: _emailController,
                            keyboard: TextInputType.name,
                           ),
                          SizedBox(
                            height: 2.h,
                          ),
                          const CustomTextField(
                            prefixIcon: Icon(Icons.phone),
                            fieldName: "Mobile Number",
                            hintName: "",
                            // fieldController: _emailController,
                            keyboard: TextInputType.number,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
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
                            fieldController: _passwordController,
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
                              Container(
                                child: Text("Already have an account?",
                                    style: FontTextStyle.poppinsS14W4BlackColor),
                              ),
                              Container(
                                  child: GestureDetector(
                                    child: Text(" Sign In",
                                        style:
                                        FontTextStyle.poppinsS12HintColor),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const LoginScreen()));
                                    },
                                  )),
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


}
