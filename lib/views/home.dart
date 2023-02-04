
import 'package:ac_tech/Utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../utils/font_utils.dart';
import '../utils/image_utils.dart';
import '../widgets/custom_btn.dart';
import 'auth/login_screen.dart';
import 'auth/signUp.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _fetchLoginData();
  // }
  // _fetchLoginData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //     if(prefs.containsKey('id'))
  //       {
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OurServices(),));
  //       }
  //     else
  //       {
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
  //       }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 120),
                Image.asset(
                  ImageUtils.splashImage,
                  height: 16.h,
                ),
                const SizedBox(height: 30),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 2.5),
                            blurRadius: 3.0,
                            color: Color.fromARGB(100, 0, 0, 0),
                          ),
                        ],
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Welcome to     '),
                        TextSpan(
                            text: ' Advance Computer Technology',
                            style: TextStyle(letterSpacing: 2.0))
                      ]),
                ),
                const SizedBox(height: 30.0),
                const Center(
                  child: Text(
                    'Already Have an Account?',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                      height: 50, //height of button
                      width: double.infinity, //width of button
                      child: CustomButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        buttonText: "Login",
                        textStyle: FontTextStyle.poppinsS14W4WhiteColor,
                      ),),
                ),
                const SizedBox(height: 15.0),
                const Center(
                  child: Text(
                    'Or',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Center(
                  child: SizedBox(
                      height: 50, //height of button
                      width: double.infinity, //width of button
                      child: CustomButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUp()),
                          );
                          child: Container(
                              decoration: BoxDecoration(
                                color: ColorUtils.redColor,
                              border: Border.all(color:ColorUtils.primaryColor),
                              borderRadius: BorderRadius.circular(50  )));
                        },
                        buttonText: "Sign Up",
                        textStyle: FontTextStyle.poppinsS14W4WhiteColor,
                      ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
