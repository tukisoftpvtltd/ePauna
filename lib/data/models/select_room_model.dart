class SelectRoom {
  SelectRoom({
    this.serviceId,
    this.selectRoomIn,
    this.out,
    this.serviceRate,
    this.serviceCategoryId,
    this.categoryName,
    this.serviceTitle,
    this.serviceSubTitle,
    this.status,
    this.imageName,
    this.serviceAndFacility,
  });

  String? serviceId;
  int? selectRoomIn;
  int? out;
  int? serviceRate;
  int? serviceCategoryId;
  String? categoryName;
  String? serviceTitle;
  String? serviceSubTitle;
  int? status;
  String? imageName;
  String? serviceAndFacility;

  factory SelectRoom.fromJson(Map<String, dynamic> json) => SelectRoom(
        serviceId: json["ServiceId"],
        selectRoomIn: json["In"],
        out: json["Out"],
        serviceRate: json["ServiceRate"],
        serviceCategoryId: json["ServiceCategoryId"],
        categoryName: json["CategoryName"],
        serviceTitle: json["ServiceTitle"],
        serviceSubTitle: json["ServiceSubTitle"],
        status: json["Status"],
        imageName: json["imageName"],
        serviceAndFacility: json["ServiceAndFacility"],
      );

  Map<String, dynamic> toJson() => {
        "ServiceId": serviceId,
        "In": selectRoomIn,
        "Out": out,
        "ServiceRate": serviceRate,
        "ServiceCategoryId": serviceCategoryId,
        "CategoryName": categoryName,
        "ServiceTitle": serviceTitle,
        "ServiceSubTitle": serviceSubTitle,
        "Status": status,
        "imageName": imageName,
        "ServiceAndFacility": serviceAndFacility,
      };
}
