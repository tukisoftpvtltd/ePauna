// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

List<RegisterModel> registerModelFromJson(String str) =>
    List<RegisterModel>.from(
        json.decode(str).map((x) => RegisterModel.fromJson(x)));

String registerModelToJson(List<RegisterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegisterModel {
  bool? status;
  String? message;
  String? userId;
  

  RegisterModel({
    this.status,
    this.message,
    this.userId,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
        message: json["message"],
        userId: json["UserId"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "UserId": userId,
      };
}
