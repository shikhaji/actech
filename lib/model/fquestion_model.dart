
import 'dart:convert';

FquestionModel fquestionModelFromJson(String str) => FquestionModel.fromJson(json.decode(str));

String fquestionModelToJson(FquestionModel data) => json.encode(data.toJson());

class FquestionModel {
  FquestionModel({
    required this.status,
    required this.message,
    required this.fquestion,
  });

  int status;
  String message;
  List<Fquestion> fquestion;

  factory FquestionModel.fromJson(Map<String, dynamic> json) => FquestionModel(
    status: json["status"],
    message: json["message"],
    fquestion: List<Fquestion>.from(json["fquestion"].map((x) => Fquestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "fquestion": List<dynamic>.from(fquestion.map((x) => x.toJson())),
  };
}

class Fquestion {
  Fquestion({
    required this.fquestionId,
    required this.fquestionTt,
    required this.fquestion,
    required this.fanswer,
    required this.fstatus,
    required this.fquestionType,
  });

  String fquestionId;
  DateTime fquestionTt;
  String fquestion;
  String fanswer;
  String fstatus;
  String fquestionType;

  factory Fquestion.fromJson(Map<String, dynamic> json) => Fquestion(
    fquestionId: json["FQUESTION_ID"],
    fquestionTt: DateTime.parse(json["FQUESTION_TT"]),
    fquestion: json["FQUESTION"],
    fanswer: json["FANSWER"],
    fstatus: json["FSTATUS"],
    fquestionType: json["FQUESTION_TYPE"],
  );

  Map<String, dynamic> toJson() => {
    "FQUESTION_ID": fquestionId,
    "FQUESTION_TT": fquestionTt.toIso8601String(),
    "FQUESTION": fquestion,
    "FANSWER": fanswer,
    "FSTATUS": fstatus,
    "FQUESTION_TYPE": fquestionType,
  };
}
