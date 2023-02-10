import 'dart:async';
import 'package:ac_tech/utils/app_assets.dart';
import 'package:ac_tech/views/splash/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/image_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      // String? id = await Preferances.getString("id");
      // String? profileStatus = await Preferances.getString("PROFILE_STATUS");
      // print("userId:=${id}");
      // print("ps:=${profileStatus}");
      // if (id != null ) {
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(
      //           builder: (context) => const dashboardScreen()),
      //       (Route<dynamic> route) => false);
      // } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (Route<dynamic> route) => false);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Center(
          child:Image.asset(
            AppAsset.splashImage,
            height: 25.h,
          ),
      ),
    ));
  }
}
