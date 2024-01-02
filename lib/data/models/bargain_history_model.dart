class BargainHistoryModel {
  final String? tCode;
  final String? sid;
  final String? userId;
  final String? hotelType;
  final String? bedType;
  final String? rate;
  final String? roomQuantity;
  final String? checkinDate;
  final String? checkoutDate;
  final int? noOfGuest;
  final String? note;
  final String? paymentMethod;
  final String? paymentId;
  final String? total;
  final String? discount;
  final String? createdAt;
  final String? updatedAt;
  final String? sidCapital;
  final String? bid;
  final String? fullName;
  final String? email;
  final int? emailVerified;
  final String? mobileNumber;
  final String? otpCode;
  final String? password;
  final String? rememberToken;
  final String? logo;
  final int? status;
  final int? serviceStatus;
  final int? approval;
  final double? latitude;
  final double? longitude;
  final String? playerId;
  final int? serviceCategoryId;

  BargainHistoryModel({
    this.tCode,
    this.sid,
    this.userId,
    this.hotelType,
    this.bedType,
    this.rate,
    this.roomQuantity,
    this.checkinDate,
    this.checkoutDate,
    this.noOfGuest,
    this.note,
    this.paymentMethod,
    this.paymentId,
    this.total,
    this.discount,
    this.createdAt,
    this.updatedAt,
    this.sidCapital,
    this.bid,
    this.fullName,
    this.email,
    this.emailVerified,
    this.mobileNumber,
    this.otpCode,
    this.password,
    this.rememberToken,
    this.logo,
    this.status,
    this.serviceStatus,
    this.approval,
    this.latitude,
    this.longitude,
    this.playerId,
    this.serviceCategoryId,
  });

  factory BargainHistoryModel.fromJson(Map<String, dynamic> json) {
    return BargainHistoryModel(
      tCode: json['tCode'],
      sid: json['sid'],
      userId: json['user_id'],
      hotelType: json['hotel_type'],
      bedType: json['bed_type'],
      rate: json['rate'],
      roomQuantity: json['room_quantity'],
      checkinDate: json['checkin_date'],
      checkoutDate: json['checkout_date'],
      noOfGuest: json['no_of_guest'],
      note: json['note'],
      paymentMethod: json['payment_method'],
      paymentId: json['payment_id'],
      total: json['total'],
      discount: json['discount'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      sidCapital: json['Sid'],
      bid: json['Bid'],
      fullName: json['FullName'],
      email: json['Email'],
      emailVerified: json['EmailVarified'],
      mobileNumber: json['MobileNumber'],
      otpCode: json['OTPCode'],
      password: json['Password'],
      rememberToken: json['RememberToken'],
      logo: json['Logo'],
      status: json['Status'],
      serviceStatus: json['ServiceStatus'],
      approval: json['Approval'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      playerId: json['playerId'],
      serviceCategoryId: json['service_category_id'],
    );
  }
}
