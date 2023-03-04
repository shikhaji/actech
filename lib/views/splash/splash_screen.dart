import 'dart:async';
import 'package:ac_tech/routes/arguments.dart';
import 'package:ac_tech/utils/app_assets.dart';
import 'package:ac_tech/views/dashboard/main_home_screen.dart';
import 'package:ac_tech/views/splash/welcome_screen.dart';
import 'package:ac_tech/widgets/custom_size_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../services/shared_preferences.dart';

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
      String? id = await Preferances.getString("userId");
      String? token = await Preferances.getString("Token");
      print("userId:=${id}");
      print("token:=${token}");
      if (id != null ) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>  MainHomeScreen(arguments: OtpArguments(bottomIndex: 0),)),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Center(
        child: Image.asset(
          AppAsset.mainLogoImage,
          height: 25.h,
        ),
      )
    ));
  }
}
