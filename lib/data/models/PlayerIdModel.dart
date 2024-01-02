class PlayerIdModel {
  bool? status;
  List<ServiceProviderPlayerIdList>? serviceProviderPlayerIdList;

  PlayerIdModel({this.status, this.serviceProviderPlayerIdList});

  PlayerIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['serviceProviderPlayerIdList'] != null) {
      serviceProviderPlayerIdList = <ServiceProviderPlayerIdList>[];
      json['serviceProviderPlayerIdList'].forEach((v) {
        serviceProviderPlayerIdList!
            .add(new ServiceProviderPlayerIdList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.serviceProviderPlayerIdList != null) {
      data['serviceProviderPlayerIdList'] =
          this.serviceProviderPlayerIdList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceProviderPlayerIdList {
  String? playerId;
  double? distance;
  double? latitude;
  double? longitude;

  ServiceProviderPlayerIdList(
      {this.playerId, this.distance, this.latitude, this.longitude});

  ServiceProviderPlayerIdList.fromJson(Map<String, dynamic> json) {
    playerId = json['playerId'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playerId'] = this.playerId;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}