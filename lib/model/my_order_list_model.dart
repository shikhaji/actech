// To parse this JSON data, do
//
//     final myOderListModel = myOderListModelFromJson(jsonString);

import 'dart:convert';

MyOderListModel myOderListModelFromJson(String str) => MyOderListModel.fromJson(json.decode(str));

String myOderListModelToJson(MyOderListModel data) => json.encode(data.toJson());

class MyOderListModel {
  MyOderListModel({
    required this.status,
    required this.message,
    required this.course,
  });

  int status;
  String message;
  List<Course> course;

  factory MyOderListModel.fromJson(Map<String, dynamic> json) => MyOderListModel(
    status: json["status"],
    message: json["message"],
    course: List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "course": List<dynamic>.from(course.map((x) => x.toJson())),
  };
}

class Course {
  Course({
    required this.pclId,
    required this.pclTt,
    required this.pclClId,
    required this.plcTransactionId,
    required this.plcPaymentDate,
    required this.plcPaymentStatus,
    required this.plcLoginId,
    required this.clTt,
    required this.ccId,
    required this.clName,
    required this.clStatus,
    required this.clId,
    required this.courseCode,
    required this.courseDuration,
    required this.courseEligibility,
    required this.coursePdf,
    required this.clVideoUrl,
    required this.ccTt,
    required this.ccName,
    required this.ccStatus,
    required this.ccCommision,
    required this.courseImage,
    required this.ccTotalLessons,
    required this.courseCategoryId,
  });

  String pclId;
  DateTime pclTt;
  String pclClId;
  String plcTransactionId;
  DateTime plcPaymentDate;
  String plcPaymentStatus;
  String plcLoginId;
  DateTime clTt;
  String ccId;
  String clName;
  String clStatus;
  String clId;
  String courseCode;
  String courseDuration;
  String courseEligibility;
  String coursePdf;
  String clVideoUrl;
  DateTime ccTt;
  String ccName;
  String ccStatus;
  String ccCommision;
  String courseImage;
  String ccTotalLessons;
  String courseCategoryId;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    pclId: json["PCL_ID"],
    pclTt: DateTime.parse(json["PCL_TT"]),
    pclClId: json["PCL_CL_ID"],
    plcTransactionId: json["PLC_TRANSACTION_ID"],
    plcPaymentDate: DateTime.parse(json["PLC_PAYMENT_DATE"]),
    plcPaymentStatus: json["PLC_PAYMENT_STATUS"],
    plcLoginId: json["PLC_LOGIN_ID"],
    clTt: DateTime.parse(json["CL_TT"]),
    ccId: json["CC_ID"],
    clName: json["CL_NAME"],
    clStatus: json["CL_STATUS"],
    clId: json["CL_ID"],
    courseCode: json["COURSE_CODE"],
    courseDuration: json["COURSE_DURATION"],
    courseEligibility: json["COURSE_ELIGIBILITY"],
    coursePdf: json["COURSE_PDF"],
    clVideoUrl: json["CL_VIDEO_URL"],
    ccTt: DateTime.parse(json["CC_TT"]),
    ccName: json["CC_NAME"],
    ccStatus: json["CC_STATUS"],
    ccCommision: json["CC_COMMISION"],
    courseImage: json["COURSE_IMAGE"],
    ccTotalLessons: json["CC_TOTAL_LESSONS"],
    courseCategoryId: json["COURSE_CATEGORY_ID"],
  );

  Map<String, dynamic> toJson() => {
    "PCL_ID": pclId,
    "PCL_TT": pclTt.toIso8601String(),
    "PCL_CL_ID": pclClId,
    "PLC_TRANSACTION_ID": plcTransactionId,
    "PLC_PAYMENT_DATE": "${plcPaymentDate.year.toString().padLeft(4, '0')}-${plcPaymentDate.month.toString().padLeft(2, '0')}-${plcPaymentDate.day.toString().padLeft(2, '0')}",
    "PLC_PAYMENT_STATUS": plcPaymentStatus,
    "PLC_LOGIN_ID": plcLoginId,
    "CL_TT": clTt.toIso8601String(),
    "CC_ID": ccId,
    "CL_NAME": clName,
    "CL_STATUS": clStatus,
    "CL_ID": clId,
    "COURSE_CODE": courseCode,
    "COURSE_DURATION": courseDuration,
    "COURSE_ELIGIBILITY": courseEligibility,
    "COURSE_PDF": coursePdf,
    "CL_VIDEO_URL": clVideoUrl,
    "CC_TT": ccTt.toIso8601String(),
    "CC_NAME": ccName,
    "CC_STATUS": ccStatus,
    "CC_COMMISION": ccCommision,
    "COURSE_IMAGE": courseImage,
    "CC_TOTAL_LESSONS": ccTotalLessons,
    "COURSE_CATEGORY_ID": courseCategoryId,
  };
}