part of 'bargain_bloc.dart';

@immutable
 class BargainEvent {}

 class getHotelCategory extends BargainEvent{
  int index;
  getHotelCategory(this.index);
 }
  class getNoOfBed extends BargainEvent{
  int index;
  getNoOfBed(this.index);
 }
  class getRange extends BargainEvent{
  double start;
  double end;
  getRange(this.start,this.end);
 }
  class getAdditionalData extends BargainEvent{
  String location;
  String rate;
  int bedQuantity;
  String startDate;
  String endDate;
  bool startDateSelected;
  bool endDateSelected;
  int personCount;
  int hourCount;
  String note;
  String latitude;
  String longitude;
  String pickUpoverAllPlaceName;
  String pickUplatitudeValue;
  String pickUplongitudeValue;
  bool hourlyBargain;
  getAdditionalData(
    this.location,
    this.rate,
    this.bedQuantity,
    this.startDate,
    this.endDate,
    this.startDateSelected,
    this.endDateSelected,
    this.personCount,
    this.hourCount,
    this.note,
    this.latitude,
    this.longitude,
    this.pickUpoverAllPlaceName,
    this.pickUplatitudeValue,
    this.pickUplongitudeValue,
    this.hourlyBargain,
  );
 }
  class sendData extends BargainEvent{
  BuildContext context;
  sendData(this.context);
 }
  class BargainNoDataEvent extends BargainEvent{
  BargainNoDataEvent();
 }
class StartTimerEvent extends BargainEvent{
  Timer timer;
  StartTimerEvent(this.timer);
 }

class CancelTimerEvent extends BargainEvent{
  Timer timer;
  CancelTimerEvent(this.timer);
 }

