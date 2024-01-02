// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

List<LoginModel> loginModelFromJson(String str) =>
    List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));

String loginModelToJson(List<LoginModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel {
  bool? status;
  String? message;
  String? userId;
  int? emailVarified;
  String? firstName;
  String? lastName;

  LoginModel({
    this.status,
    this.message,
    this.userId,
    this.emailVarified,
    this.firstName,
    this.lastName,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        userId: json["UserId"],
        emailVarified: json["EmailVarified"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "UserId": userId,
        "EmailVarified": emailVarified,
        "FirstName": firstName,
        "LastName": lastName,
      };
}
