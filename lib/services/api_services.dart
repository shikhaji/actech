import 'dart:convert';

import 'package:ac_tech/services/shared_preference.dart';
import 'package:dio/dio.dart';

import 'api_endpoint.dart';
import 'dio_client.dart';
import 'package:http/http.dart' as http;

Dio dio = Dio();

class ApiService {
  ApiClient apiClient = ApiClient();

  // Future<LoginModel?> login(
  //   BuildContext context, {
  //   FormData? data,
  // }) async {
  //   try {
  //     Loader.showLoader();
  //     print("login try");
  //     Response response;
  //     response = await dio.post(ApiEndPoints.loginApi,
  //         options: Options(headers: {
  //           "Client-Service": 'frontend-client',
  //           'Auth-Key': 'simplerestapi'
  //         }),
  //         data: data);
  //     LoginModel responseData = LoginModel.fromJson(response.data);
  //     if (responseData.message == "ok") {
  //       var cookies = response.headers['set-cookie'];
  //       print("cookies:=${cookies![0].split(';')[0]}");
  //
  //       debugPrint('login data  ----- > ${response.data}');
  //       Preferances.setString("id", responseData.id);
  //       Preferances.setString("token", responseData.token);
  //       Preferances.setString("type", responseData.type);
  //       Preferances.setString("PROFILE_STATUS", responseData.pROFILESTATUS);
  //       Preferances.setString("cookie", cookies[0].split(';')[0]);
  //
  //       if (responseData.pROFILESTATUS == '0') {
  //         Navigator.of(context).pushAndRemoveUntil(
  //             MaterialPageRoute(
  //                 builder: (context) => UpdateProfile(
  //                       userId: "${responseData.id}",
  //                       token: "${responseData.token}",
  //                       type: "${responseData.type}",
  //                     )),
  //             (Route<dynamic> route) => false);
  //       } else if (responseData.pROFILESTATUS == '1') {
  //         Navigator.of(context).pushAndRemoveUntil(
  //             MaterialPageRoute(
  //                 builder: (context) => const BottomNavBar(
  //                       index: 0,
  //                     )),
  //             (Route<dynamic> route) => false);
  //       }
  //       Fluttertoast.showToast(
  //         msg: 'Login Sucessfully',
  //         backgroundColor: Colors.grey,
  //       );
  //       Loader.hideLoader();
  //       return responseData;
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: "Invalid Phone Number/Password",
  //         backgroundColor: Colors.grey,
  //       );
  //       Loader.hideLoader();
  //       throw Exception(response.data);
  //     }
  //   } on DioError catch (e) {
  //     print("dio");
  //     debugPrint('Dio E  $e');
  //     debugPrint('Dio E  $e');
  //     Loader.hideLoader();
  //   }
  // }
  //
  //
  // Future<MobileVerifyModel?> mobileVerify(
  //   BuildContext context, {
  //   FormData? data,
  //   String? mobile,
  // }) async {
  //   try {
  //     Loader.showLoader();
  //     print("Register check try:=${mobile}");
  //     Response response;
  //     response = await dio.post(ApiEndPoints.mobileVerify,
  //         options: Options(headers: {
  //           "Client-Service": 'frontend-client',
  //           'Auth-Key': 'simplerestapi'
  //         }),
  //         data: data);
  //
  //     MobileVerifyModel responseData =
  //         MobileVerifyModel.fromJson(response.data);
  //     print("responseData:=${responseData}");
  //     print("responseData.status:=${responseData.status}");
  //     if (responseData.message == "ok") {
  //
  //       print("responseData.bjjhstatus:=${responseData.status}");
  //
  //       return responseData;
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: "invalid",
  //         backgroundColor: Colors.grey,
  //       );
  //
  //       Loader.hideLoader();
  //       throw Exception(response.data);
  //     }
  //   } on DioError catch (e) {
  //     print("dio");
  //     debugPrint('Dio E  $e');
  //     debugPrint('Dio E  $e');
  //     Loader.hideLoader();
  //   }
  // }
  //
  // Future addAccount(
  //   BuildContext context, {
  //   FormData? data,
  // }) async {
  //   try {
  //     Loader.showLoader();
  //     String? id = await Preferances.getString("id");
  //     String? token = await Preferances.getString("token");
  //     String? type = await Preferances.getString("type");
  //     String? profileStatus = await Preferances.getString("PROFILE_STATUS");
  //     Response response;
  //     response =
  //         await dio.post("https://celebrationstation.in/post_ajax/add_account/",
  //             options: Options(headers: {
  //               'Client-Service': 'frontend-client',
  //               'Auth-Key': 'simplerestapi',
  //               'User-ID': id,
  //               'Authorization': token,
  //               'type': type
  //             }),
  //             data: data);
  //     if (response.statusCode == 200) {
  //       debugPrint('Add Account ----- > ${response.data}');
  //       Loader.hideLoader();
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) =>LoginScreen(),
  //           ));
  //       Fluttertoast.showToast(
  //         msg: 'Add Account  Sucessfully...',
  //         backgroundColor: Colors.grey,
  //       );
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: "invalid",
  //         backgroundColor: Colors.grey,
  //       );
  //       Loader.hideLoader();
  //
  //       throw Exception(response.data);
  //     }
  //   } on DioError catch (e) {
  //     print("dio");
  //     debugPrint('Dio E  $e');
  //     Loader.hideLoader();
  //   }
  // }
  //
  //
  // Future resetPassword(
  //     BuildContext context, {
  //       FormData? data,
  //     }) async {
  //   try {
  //     Loader.showLoader();
  //     Response response;
  //     response = await dio.post('https://celebrationstation.in/post_ajax/update_reset_pasword/',
  //         // options: Options(headers: {
  //         //   'Client-Service': 'frontend-client',
  //         //   'Auth-Key': 'simplerestapi',
  //         //   'User-ID': id,
  //         //   'Authorization': token,
  //         //   'type': type
  //         // }),
  //         data: data);
  //     if (response.statusCode == 200) {
  //       debugPrint('reset Password ----- > ${response.data}');
  //       Loader.hideLoader();
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => LoginScreen(),
  //           ));
  //       Fluttertoast.showToast(
  //         msg: 'reset Password Sucessfully...',
  //         backgroundColor: Colors.grey,
  //       );
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: "invalid",
  //         backgroundColor: Colors.grey,
  //       );
  //       Loader.hideLoader();
  //
  //       throw Exception(response.data);
  //     }
  //   } on DioError catch (e) {
  //     print("dio");
  //     debugPrint('Dio E  $e');
  //     Loader.hideLoader();
  //   }
  // }
  //


}
