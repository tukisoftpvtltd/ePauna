import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/bookings_cubit/bookings_state.dart';
import '/data/models/bookings.dart';
import '/data/repository/bookings.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit() : super(BookingsLoading()) {
    fetchBookings();
  }

  BookingsRepository bookingsRepository = BookingsRepository();
  void fetchBookings() async {
    try {
      List<BookingsModel> bookings = await bookingsRepository.fecthBookings();
      emit(BookingsLoaded(bookings));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.unknown) {
        emit(BookingsError(
            'Can\'t fetch the data please check your internet connection'));
      } else {
        emit(BookingsError(ex.toString()));
      }
    }
  }
}
