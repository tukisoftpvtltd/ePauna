import 'dart:convert';

BookingsModel bookingsModelFromJson(String str) =>
    BookingsModel.fromJson(json.decode(str));

String bookingsModelToJson(BookingsModel data) => json.encode(data.toJson());

class BookingsModel {
  BookingsModel({
    required this.fullName,
    required this.sid,
    required this.logo,
    required this.serviceTitle,
    required this.address,
    required this.city,
    required this.serviceSubTitle,
    required this.rate,
    required this.imageName,
    required this.qty,
    required this.checkIn,
    required this.checkOut,
    required this.totalAmount,
    required this.discount,
    required this.averageRating,
  });

  String fullName;
  String sid;
  String logo;
  String serviceTitle;
  String address;
  String city;
  String serviceSubTitle;
  int rate;
  String imageName;
  int qty;
  DateTime checkIn;
  DateTime checkOut;
  int totalAmount;
  int discount;
  dynamic averageRating;

  factory BookingsModel.fromJson(Map<String, dynamic> json) => BookingsModel(
        fullName: json["FullName"],
        sid: json["Sid"],
        logo: json["Logo"],
        serviceTitle: json["ServiceTitle"],
        address: json["Address"],
        city: json["City"],
        serviceSubTitle: json["ServiceSubTitle"],
        rate: json["Rate"],
        imageName: json["imageName"],
        qty: json["Qty"],
        checkIn: DateTime.parse(json["CheckIn"]),
        checkOut: DateTime.parse(json["CheckOut"]),
        totalAmount: json["TotalAmount"],
        discount: json["Discount"],
        averageRating: json["AverageRating"],
      );

  Map<String, dynamic> toJson() => {
        "FullName": fullName,
        "Sid": sid,
        "Logo": logo,
        "ServiceTitle": serviceTitle,
        "Address": address,
        "City": city,
        "ServiceSubTitle": serviceSubTitle,
        "Rate": rate,
        "imageName": imageName,
        "Qty": qty,
        "CheckIn":
            "${checkIn.year.toString().padLeft(4, '0')}-${checkIn.month.toString().padLeft(2, '0')}-${checkIn.day.toString().padLeft(2, '0')}",
        "CheckOut":
            "${checkOut.year.toString().padLeft(4, '0')}-${checkOut.month.toString().padLeft(2, '0')}-${checkOut.day.toString().padLeft(2, '0')}",
        "TotalAmount": totalAmount,
        "Discount": discount,
        "AverageRating": averageRating,
      };
}
