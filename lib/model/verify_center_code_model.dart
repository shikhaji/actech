// To parse this JSON data, do
//
//     final verifyCenteCode = verifyCenteCodeFromJson(jsonString);

import 'dart:convert';

VerifyCenteCode verifyCenteCodeFromJson(String str) => VerifyCenteCode.fromJson(json.decode(str));

String verifyCenteCodeToJson(VerifyCenteCode data) => json.encode(data.toJson());

class VerifyCenteCode {
  VerifyCenteCode({
    this.status,
    this.message,
    this.center,
  });

  int? status;
  String? message;
  CenterCode? center;

  factory VerifyCenteCode.fromJson(Map<String, dynamic> json) => VerifyCenteCode(
    status: json["status"],
    message: json["message"],
    center: CenterCode.fromJson(json["center"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "center": center?.toJson(),
  };
}

class CenterCode {
  CenterCode({
     this.scid,
    this.centerCode,
    this.branchName,
     this.directorName,
     this.address,
     this.pics,
     this.mobile,
     this.regisdate,
     this.districtName,
     this.stateName,
     this.subAdminLoginId,
  });

  String? scid;
  String? centerCode;
  String? branchName;
  String? directorName;
  String? address;
  String? pics;
  String? mobile;
  DateTime? regisdate;
  String? districtName;
  String? stateName;
  String? subAdminLoginId;

  factory CenterCode.fromJson(Map<String, dynamic> json) => CenterCode(
    scid: json["scid"],
    centerCode: json["center_code"],
    branchName: json["branch_name"],
    directorName: json["director_name"],
    address: json["address"],
    pics: json["pics"],
    mobile: json["mobile"],
    regisdate: DateTime.parse(json["Regisdate"]),
    districtName: json["district_name"],
    stateName: json["state_name"],
    subAdminLoginId: json["SUB_ADMIN_LOGIN_ID"],
  );

  Map<String, dynamic> toJson() => {
    "scid": scid,
    "center_code": centerCode,
    "branch_name": branchName,
    "director_name": directorName,
    "address": address,
    "pics": pics,
    "mobile": mobile,
    "Regisdate": "${regisdate?.year.toString().padLeft(4, '0')}-${regisdate?.month.toString().padLeft(2, '0')}-${regisdate?.day.toString().padLeft(2, '0')}",
    "district_name": districtName,
    "state_name": stateName,
    "SUB_ADMIN_LOGIN_ID": subAdminLoginId,
  };
}
