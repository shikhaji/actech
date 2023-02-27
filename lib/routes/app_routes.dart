
import 'package:ac_tech/views/auth/edit_profile.dart';
import 'package:ac_tech/views/auth/reset_password_screen.dart';
import 'package:ac_tech/views/dashboard/introduction_video_screen.dart';
import 'package:ac_tech/views/dashboard/main_home_screen.dart';
import 'package:flutter/material.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/mobile_verification_screen.dart';
import '../views/auth/otp_verification_screen.dart';
import '../views/auth/signUp.dart';
import '../views/dashboard/chapter_display_screen.dart';
import '../views/dashboard/course_details_screen.dart';
import '../views/dashboard/fquestionScreen.dart';
import '../views/dashboard/my_order_screen.dart';
import '../views/dashboard/payment_Desecription.dart';
import '../views/dashboard/video_player_screen.dart';
import '../views/splash/splash_screen.dart';
import 'arguments.dart';

class Routs {
  static const String splash = "/splash_screen";
  static const String login = "/login_screen";
  static const String signUp = "/signUp";
  static const String forgotPassword = "/forgot_password_number_screen";
  static const String resetPassword = "/reset_password_screen";
  static const String otp = "/otp_verification_screen";
  static const String mobileVerification = "/mobile_verification_screen";
  static const String mainHome = "/main_home_screen";
  static const String fquestion = "/fquestionScreen";
  static const String courseDetail = "/course_details_screen";
  static const String videoPlayer = "/video_player_screen";
  static const String editProfile = "/edit_profile";
  static const String myOrder = "/my_order";
  static const String paymentDes = "/payment_Desecripiton";
  static const String chapterDisplay = "/chapter_display_screen";
  static const String introductionVideo = "/introduction_video_screen";
}

class RoutGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case Routs.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routs.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routs.signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen(arguments: arguments as OtpArguments,));


      case Routs.otp:
        return MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(
              arguments: arguments as OtpArguments,
            ));

       case Routs.mobileVerification:
        return MaterialPageRoute(
            builder: (_) => const MobileVerificationScreen());

      case Routs.mainHome:
        return MaterialPageRoute(
            builder: (_) =>  MainHomeScreen(index: 0,));

      case Routs.resetPassword:
        return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(arguments: arguments as OtpArguments,));

      case Routs.fquestion:
        return MaterialPageRoute(
            builder: (_) => const FquestionScreen());

      case Routs.videoPlayer:
        return MaterialPageRoute(
            builder: (_) => VideoPlayerScreen(arguments: arguments as OtpArguments,));

      case Routs.courseDetail:
        return MaterialPageRoute(
            builder: (_) => CourseDetailsScreen(
              arguments: arguments as OtpArguments,
            ));

      case Routs.editProfile:
        return MaterialPageRoute(
            builder: (_) => EditProfile());

      case Routs.myOrder:
        return MaterialPageRoute(
            builder: (_) => MyOrderScreen());

      case Routs.paymentDes:
        return MaterialPageRoute(
            builder: (_) => PaymentDes(arguments: arguments as OtpArguments,));

      case Routs.chapterDisplay:
        return MaterialPageRoute(
            builder: (_) => ChapterDisplayScreen(arguments: arguments as OtpArguments,));

      case Routs.introductionVideo:
        return MaterialPageRoute(
            builder: (_) => IntroductionVideo(arguments: arguments as OtpArguments,));


      default:
        return null;
    }
  }
}
