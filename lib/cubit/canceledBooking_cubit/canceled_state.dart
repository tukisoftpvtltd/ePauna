part of 'canceled_cubit.dart';

abstract class CanceledBookingState {}

class CancelBookingInitial extends CanceledBookingState {}

class CancelBookingLoaded extends CanceledBookingState {
  List<BookingsModel> bookings;
  CancelBookingLoaded(this.bookings);
}

class CancelBookingError extends CanceledBookingState {
  final String error;
  CancelBookingError(this.error);
}
