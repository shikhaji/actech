import 'package:ac_tech/services/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../API/dio_client.dart';
import '../API/url.dart';
import '../model/login_model.dart';
import '../model/mobile_verify_model.dart';
import '../model/slider_model.dart';
import '../routes/app_routes.dart';
import '../utils/function.dart';
import '../utils/loader.dart';
import '../views/Auth/login_screen.dart';

class ApiService {
  ApiClient apiClient = ApiClient();
  Dio dio = Dio();

  //----------------------------MOBILE VERIFY API-----------------------//
  Future<MobileVerifyModel?> mobileVerifyApi(
      BuildContext context, {
        FormData? data,
      }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.mobileVerify,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        Loader.hideLoader();
        MobileVerifyModel responseData =
        MobileVerifyModel.fromJson(response.data);
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }
  //----------------------------SIGNUP API-----------------------//
  Future signUp(
      BuildContext context, {
        FormData? data,
      }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.signUp,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        Loader.hideLoader();
        Fluttertoast.showToast(
          msg: 'Sign Up Successfully...',
          backgroundColor: Colors.grey,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

        debugPrint('responseData ----- > ${response.data}');
        return response.data;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

  //----------------------------LOGIN API-----------------------//

  Future<LoginModel?> login(
      BuildContext context, {
        FormData? data,
        String? phoneNumber,
      }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.login,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);
      if (response.statusCode == 200 ) {
        LoginModel responseData = LoginModel.fromJson(response.data);
        Preferances.setString("userId", responseData.id);
        Preferances.setString("Token", responseData.token);

        Loader.hideLoader();

        CommonFunctions.toast("login successfully");
      Navigator.pushNamed(context, Routs.mainHome);
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        CommonFunctions.toast("Invalid Login Credential");
        Loader.hideLoader();
        print("here");
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
    } finally {
      Loader.hideLoader();
    }
    return null;
  }

//----------------------------RESET PASSWORD API-----------------------//
  Future UpdatePassword(
      BuildContext context, {
        FormData? data,
      }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.updatePassword,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        Loader.hideLoader();
        Fluttertoast.showToast(
          msg: 'Password Updated Successfully...',
          backgroundColor: Colors.grey,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

        debugPrint('responseData ----- > ${response.data}');
        return response.data;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

  //-----------------------SLIDER API-----------------------//
  // Future<SliderModel> slider() async {
  //   try {
  //     Loader.showLoader();
  //     Response response;
  //     response = await dio.post(EndPoints.slider);
  //     if (response.statusCode == 200) {
  //       SliderModel responseData = SliderModel.fromJson(response.data);
  //       Loader.hideLoader();
  //       debugPrint('responseData ----- > ${response.data}');
  //       return responseData;
  //     } else {
  //       Loader.hideLoader();
  //       throw Exception(response.data);
  //     }
  //   } on DioError catch (e) {
  //     Loader.hideLoader();
  //     debugPrint('Dio E  $e');
  //     throw e.error;
  //   }
  // }
  Future<SliderModel> slider(BuildContext context,) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.slider);

      if (response.statusCode == 200) {
        SliderModel responseData = SliderModel.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

 }
