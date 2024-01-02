import 'dart:convert';

List<DynamicServicesModel> dynamicServicesModelFromJson(String str) =>
    List<DynamicServicesModel>.from(
        json.decode(str).map((x) => DynamicServicesModel.fromJson(x)));

String dynamicServicesModelToJson(List<DynamicServicesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DynamicServicesModel {
  DynamicServicesModel({
    this.name,
    this.id,
    this.recods,
  });

  String? name;
  int? id;
  List<Recod>? recods;

  factory DynamicServicesModel.fromJson(Map<String, dynamic> json) =>
      DynamicServicesModel(
        name: json["name"],
        id: json["id"],
        recods: List<Recod>.from(json["recods"].map((x) => Recod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "recods": List<dynamic>.from(recods!.map((x) => x.toJson())),
      };
}

class Recod {
  Recod({
    this.fullName,
    this.sid,
    this.categoryName,
    this.logo,
    this.address,
    this.city,
    this.description,
    this.min,
    this.max,
  });

  String? fullName;
  String? sid;
  String? categoryName;
  String? logo;
  String? address;
  String? city;
  String? description;
  int? min;
  int? max;

  factory Recod.fromJson(Map<String, dynamic> json) => Recod(
        fullName: json["FullName"],
        sid: json["Sid"],
        categoryName: json["categoryName"],
        logo: json["Logo"],
        address: json["Address"],
        city: json["City"],
        description: json["Description"],
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "FullName": fullName,
        "Sid": sid,
        "categoryName": categoryName,
        "Logo": logo,
        "Address": address,
        "City": city,
        "Description": description,
        "min": min,
        "max": max,
      };
}
