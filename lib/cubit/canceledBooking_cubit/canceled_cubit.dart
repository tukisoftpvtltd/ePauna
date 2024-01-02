import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/models/bookings.dart';
import '/data/repository/canceled_booking.dart';
part 'canceled_state.dart';

class CanceledBookingsCubit extends Cubit<CanceledBookingState> {
  CanceledBookingsCubit() : super(CancelBookingInitial()) {
    fetchCancelBookings();
  }
  CancelBookingsRepository cancelBookingsRepository =
      CancelBookingsRepository();
  void fetchCancelBookings() async {
    try {
      List<BookingsModel> bookings =
          await cancelBookingsRepository.canceledBookings();
      emit(CancelBookingLoaded(bookings));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.unknown) {
        emit(CancelBookingError(
            'Can\'t fetch the data please check your internet connection'));
      } else {
        emit(CancelBookingError(ex.toString()));
      }
    }
  }
}
