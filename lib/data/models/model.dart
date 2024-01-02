class Model {
  Model(
      {this.fullName,
      this.sid,
      this.categoryName,
      this.logo,
      this.address,
      this.city,
      this.description,
      this.min,
      this.max,
      this.averageRating});

  String? fullName;
  String? sid;
  String? categoryName;
  String? logo;
  String? address;
  String? city;
  String? description;
  int? min;
  int? max;
  dynamic averageRating;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        fullName: json["FullName"],
        sid: json["Sid"],
        categoryName: json["categoryName"],
        logo: json["Logo"],
        address: json["Address"],
        city: json["City"],
        description: json["Description"],
        min: json["min"],
        max: json["max"],
        averageRating: json["AverageRating"],
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
        "AverageRating": averageRating,
      };
}

// !This is the Model for image in Desc
class DescPics extends Model {
  DescPics({
    this.spgId,
    // this.sid,
    this.image,
    this.caption,
  });

  String? spgId;
  // String? sid;
  String? image;
  dynamic caption;

  factory DescPics.fromJson(Map<String, dynamic> json) => DescPics(
        spgId: json["SPGId"],
        // sid: json["Sid"],
        image: json["Image"],
        caption: json["Caption"],
      );

  Map<String, dynamic> toJson() => {
        "SPGId": spgId,
        // "Sid": sid,
        "Image": image,
        "Caption": caption,
      };
}
