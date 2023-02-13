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
  });

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

  factory Course.fromJson(Map<String, dynamic> json) => Course(
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
  );

  Map<String, dynamic> toJson() => {
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
  };
}
