// To parse this JSON data, do
//
//     final getAllCourseCategoryId = getAllCourseCategoryIdFromJson(jsonString);

import 'dart:convert';

GetAllCourseCategoryId getAllCourseCategoryIdFromJson(String str) => GetAllCourseCategoryId.fromJson(json.decode(str));

String getAllCourseCategoryIdToJson(GetAllCourseCategoryId data) => json.encode(data.toJson());

class GetAllCourseCategoryId {
  GetAllCourseCategoryId({
    required this.status,
    required this.message,
    required this.course,
  });

  int status;
  String message;
  List<Course> course;

  factory GetAllCourseCategoryId.fromJson(Map<String, dynamic> json) => GetAllCourseCategoryId(
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
    required this.cvlTt,
    required this.cvlCcfvId,
    required this.cvlName,
    required this.cvlStatus,
    required this.cvlId,
    required this.cvlCoursePdf,
    required this.cvlVideoUrl,
    required this.ccfvId,
    required this.ccfvTt,
    required this.ccfvName,
    required this.ccfvStatus,
    required this.ccfvCommision,
    required this.ccfvCourseImage,
    required this.ccfvTotalLessons,
    required this.ccfvUrl,
  });

  DateTime cvlTt;
  String cvlCcfvId;
  String cvlName;
  String cvlStatus;
  String cvlId;
  String cvlCoursePdf;
  String cvlVideoUrl;
  String ccfvId;
  DateTime ccfvTt;
  String ccfvName;
  String ccfvStatus;
  String ccfvCommision;
  String ccfvCourseImage;
  String ccfvTotalLessons;
  String ccfvUrl;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    cvlTt: DateTime.parse(json["CVL_TT"]),
    cvlCcfvId: json["CVL_CCFV_ID"],
    cvlName: json["CVL_NAME"],
    cvlStatus: json["CVL_STATUS"],
    cvlId: json["CVL_ID"],
    cvlCoursePdf: json["CVL_COURSE_PDF"],
    cvlVideoUrl: json["CVL_VIDEO_URL"],
    ccfvId: json["CCFV_ID"],
    ccfvTt: DateTime.parse(json["CCFV_TT"]),
    ccfvName: json["CCFV_NAME"],
    ccfvStatus: json["CCFV_STATUS"],
    ccfvCommision: json["CCFV_COMMISION"],
    ccfvCourseImage: json["CCFV_COURSE_IMAGE"],
    ccfvTotalLessons: json["CCFV_TOTAL_LESSONS"],
    ccfvUrl: json["CCFV_URL"],
  );

  Map<String, dynamic> toJson() => {
    "CVL_TT": cvlTt.toIso8601String(),
    "CVL_CCFV_ID": cvlCcfvId,
    "CVL_NAME": cvlName,
    "CVL_STATUS": cvlStatus,
    "CVL_ID": cvlId,
    "CVL_COURSE_PDF": cvlCoursePdf,
    "CVL_VIDEO_URL": cvlVideoUrl,
    "CCFV_ID": ccfvId,
    "CCFV_TT": ccfvTt.toIso8601String(),
    "CCFV_NAME": ccfvName,
    "CCFV_STATUS": ccfvStatus,
    "CCFV_COMMISION": ccfvCommision,
    "CCFV_COURSE_IMAGE": ccfvCourseImage,
    "CCFV_TOTAL_LESSONS": ccfvTotalLessons,
    "CCFV_URL": ccfvUrl,
  };
}
