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
    required this.ccId,
    required this.ccTt,
    required this.ccName,
    required this.ccStatus,
    required this.ccCommision,
    required this.courseImage,
  });

  String ccId;
  DateTime ccTt;
  String ccName;
  String ccStatus;
  String ccCommision;
  String courseImage;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    ccId: json["CC_ID"],
    ccTt: DateTime.parse(json["CC_TT"]),
    ccName: json["CC_NAME"],
    ccStatus: json["CC_STATUS"],
    ccCommision: json["CC_COMMISION"],
    courseImage: json["COURSE_IMAGE"],
  );

  Map<String, dynamic> toJson() => {
    "CC_ID": ccId,
    "CC_TT": ccTt.toIso8601String(),
    "CC_NAME": ccName,
    "CC_STATUS": ccStatus,
    "CC_COMMISION": ccCommision,
    "COURSE_IMAGE": courseImage,
  };
}
