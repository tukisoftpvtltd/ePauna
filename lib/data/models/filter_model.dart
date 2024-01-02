// // To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

List<FilterModel> filterModelFromJson(String str) => List<FilterModel>.from(
    json.decode(str).map((x) => FilterModel.fromJson(x)));

String filterModelToJson(List<FilterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterModel {
  String? name;
  int? id;

  FilterModel({
    this.name,
    this.id,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
