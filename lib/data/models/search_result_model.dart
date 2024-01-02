import 'dart:convert';

List<SearchResultModel> searchResultModelFromJson(String str) =>
    List<SearchResultModel>.from(
        json.decode(str).map((x) => SearchResultModel.fromJson(x)));

String searchResultModelToJson(List<SearchResultModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchResultModel {
  String? keyword;

  SearchResultModel({
    this.keyword,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        keyword: json["keyword"],
      );

  Map<String, dynamic> toJson() => {
        "keyword": keyword,
      };
}
