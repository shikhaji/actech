import 'dart:core';

class EndPoints {
  static const String baseUrl = "https://www.actechindia.org/";
  static const String get = "get_ajax";
  static const String post = "post_ajax";
  static const String mobileVerify = '$baseUrl/$get/mobile_verify';
  static const String signUp = '$baseUrl/$post/add_student_account';
  static const String updatePassword = '$baseUrl/$post/update_reset_pasword';
  static const String login = '$baseUrl/$get/login';

}
