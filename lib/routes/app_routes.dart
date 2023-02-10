
import 'package:ac_tech/views/auth/reset_password_screen.dart';
import 'package:ac_tech/views/dashboard/main_home_screen.dart';
import 'package:flutter/material.dart';

import '../services/shared_preferences.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/mobile_verification_screen.dart';
import '../views/auth/otp_verification_screen.dart';
import '../views/auth/signUp.dart';
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

}

class RoutGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case Routs.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routs.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      // case Routs.forgotPassword:
      //   return MaterialPageRoute(builder: (_) => const ForgotPassword());

      // case Routs.resetPassword:
      //   return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

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
            builder: (_) => const MainHomeScreen());

      case Routs.resetPassword:
        return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(arguments: arguments as OtpArguments,));

      default:
        return null;
    }
  }
}
