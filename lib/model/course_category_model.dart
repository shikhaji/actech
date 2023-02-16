// To parse this JSON data, do
//
//     final getAllCourseCategory = getAllCourseCategoryFromJson(jsonString);

import 'dart:convert';

GetAllCourseCategory getAllCourseCategoryFromJson(String str) => GetAllCourseCategory.fromJson(json.decode(str));

String getAllCourseCategoryToJson(GetAllCourseCategory data) => json.encode(data.toJson());

class GetAllCourseCategory {
  GetAllCourseCategory({
    required this.status,
    required this.message,
    required this.course,
  });

  int status;
  String message;
  List<Course> course;

  factory GetAllCourseCategory.fromJson(Map<String, dynamic> json) => GetAllCourseCategory(
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
    required this.ccfvId,
    required this.ccfvTt,
    required this.ccfvName,
    required this.ccfvStatus,
    required this.ccfvCommision,
    required this.ccfvCourseImage,
    required this.ccfvTotalLessons,
    required this.ccfvUrl,
  });

  String ccfvId;
  DateTime ccfvTt;
  String ccfvName;
  String ccfvStatus;
  String ccfvCommision;
  String ccfvCourseImage;
  String ccfvTotalLessons;
  String ccfvUrl;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
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
