// To parse this JSON data, do
//
//     final TransactionsModel = TransactionsModelFromJson(jsonString);

import 'dart:convert';

TransactionsModel TransactionsModelFromJson(String str) => TransactionsModel.fromJson(json.decode(str));

String TransactionsModelToJson(TransactionsModel data) => json.encode(data.toJson());

class TransactionsModel {
  TransactionsModel({
    required this.fullName,
    required this.sid,
    required this.checkIn,
    required this.checkOut,
    required this.totalAmount,
    required this.discount,
    required this.createdAt,
    required this.transactionCode,
  });

  String fullName;
  String sid;
  DateTime checkIn;
  DateTime checkOut;
  int totalAmount;
  int discount;
  DateTime createdAt;
  String transactionCode;

  factory TransactionsModel.fromJson(Map<String, dynamic> json) => TransactionsModel(
        fullName: json["FullName"],
        sid: json["Sid"],
        checkIn: DateTime.parse(json["CheckIn"]),
        checkOut: DateTime.parse(json["CheckOut"]),
        totalAmount: json["TotalAmount"],
        discount: json["Discount"],
        createdAt: DateTime.parse(json["created_at"]),
        transactionCode: json["TransactionCode"],
      );

  Map<String, dynamic> toJson() => {
        "FullName": fullName,
        "Sid": sid,
        "CheckIn":
            "${checkIn.year.toString().padLeft(4, '0')}-${checkIn.month.toString().padLeft(2, '0')}-${checkIn.day.toString().padLeft(2, '0')}",
        "CheckOut":
            "${checkOut.year.toString().padLeft(4, '0')}-${checkOut.month.toString().padLeft(2, '0')}-${checkOut.day.toString().padLeft(2, '0')}",
        "TotalAmount": totalAmount,
        "Discount": discount,
        "created_at": createdAt.toIso8601String(),
        "TransactionCode": transactionCode,
      };
}
