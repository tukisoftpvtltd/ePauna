import '/data/models/bookings.dart';

abstract class BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingsLoaded extends BookingsState {
  List<BookingsModel> bookings;
  BookingsLoaded(this.bookings);
}

class BookingsError extends BookingsState {
  final String error;
  BookingsError(this.error);
}
