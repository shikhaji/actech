// To parse this JSON data, do
//
//     final getAllCourseCategory = getAllCourseCategoryFromJson(jsonString);

import 'dart:convert';

GetAllCourseCategory getAllCourseCategoryFromJson(String str) => GetAllCourseCategory.fromJson(json.decode(str));

String getAllCourseCategoryToJson(GetAllCourseCategory data) => json.encode(data.toJson());

class GetAllCourseCategory {
  GetAllCourseCategory({
     this.status,
     this.message,
     this.course,
  });

  int? status;
  String? message;
  List<Course> ?course;

  factory GetAllCourseCategory.fromJson(Map<String, dynamic> json) => GetAllCourseCategory(
    status: json["status"],
    message: json["message"],
    course: List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "course": List<dynamic>.from(course!.map((x) => x.toJson())),
  };
}

class Course {
  Course({
     this.ccId,
     this.ccName,
     this.ccStatus,
     this.ccCommision,
     this.courseImage,
     this.ccTotalLessons,
  });

  String? ccId;
  String? ccName;
  String? ccStatus;
  String? ccCommision;
  String? courseImage;
  String? ccTotalLessons;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    ccId: json["CC_ID"],
    ccName: json["CC_NAME"],
    ccStatus: json["CC_STATUS"],
    ccCommision: json["CC_COMMISION"],
    courseImage: json["COURSE_IMAGE"],
    ccTotalLessons: json["CC_TOTAL_LESSONS"],
  );

  Map<String, dynamic> toJson() => {
    "CC_ID": ccId,
    "CC_NAME": ccName,
    "CC_STATUS": ccStatus,
    "CC_COMMISION": ccCommision,
    "COURSE_IMAGE": courseImage,
    "CC_TOTAL_LESSONS": ccTotalLessons,
  };
}
