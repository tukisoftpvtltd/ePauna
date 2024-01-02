import 'package:dio/dio.dart';
import '/data/models/bookings.dart';
import '/data/user_data/data.dart';
import 'api/api.dart';

class CancelBookingsRepository {
  AppData data = AppData();
  API api = API();

  Future<List<BookingsModel>> canceledBookings() async {
    try {
      Response response =
          await api.sendRequest.get('/api/selectCanceledBookings/$user_id');

      List<dynamic> postMaps = response.data;
      return postMaps
          .map((postMap) => BookingsModel.fromJson(postMap))
          .toList();
    } catch (ex) {
      throw ex;
    }
  }
}
