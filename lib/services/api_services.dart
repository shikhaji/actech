import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../API/dio_client.dart';
import '../API/url.dart';
import '../routes/app_routes.dart';
import '../utils/loader.dart';
import '../views/Auth/login_screen.dart';

class ApiService {
  ApiClient apiClient = ApiClient();
  Dio dio = Dio();

  //----------------------------MOBILE VERIFY API-----------------------//
  // Future<MobileVerifyModel?> mobileVerifyApi(
  //     BuildContext context, {
  //       FormData? data,
  //     }) async {
  //   try {
  //     Loader.showLoader();
  //     Response response;
  //     response = await dio.post(EndPoints.mobileVerify,
  //         options: Options(headers: {
  //           "Client-Service": "frontend-client",
  //           "Auth-Key": 'simplerestapi',
  //         }),
  //         data: data);
  //
  //     if (response.statusCode == 200) {
  //       Loader.hideLoader();
  //       MobileVerifyModel responseData =
  //       MobileVerifyModel.fromJson(response.data);
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

 }
