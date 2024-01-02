import 'package:dio/dio.dart';
import '/data/models/bookings.dart';
import '/data/user_data/data.dart';
import 'api/api.dart';

class BookingsRepository {
  AppData data = AppData();
  API api = API();

  Future<List<BookingsModel>> fecthBookings() async {
    print("Value is: ${await data.userId()}");
    try {
      Response response =
          await api.sendRequest.get('/api/selectBookings/$user_id');

      List<dynamic> postMaps = response.data;
      return postMaps
          .map((postMap) => BookingsModel.fromJson(postMap))
          .toList();
    } catch (ex) {
      throw ex;
    }
  }
}
