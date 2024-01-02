import 'dart:convert';

import 'package:ePauna/data/models/status_model.dart';
import 'package:ePauna/data/user_data/data.dart';
import 'package:http/http.dart' as http;

class AddRatingsRepository {
  Future<StatusModel> addRatings(String sId, dynamic star) async {
    String? userId = await AppData().userId();
    try {
      var url =
          'https://pauna.tukisoft.com.np/api/postUserReviewOnServiceProvider?user_id=$userId';

      var body = {"s_id": '$sId', "star": '$star'};
      var response = await http.post(Uri.parse(url), body: body);
      print(response.body);
      var jsonDecoded = jsonDecode(response.body);
      StatusModel statusModel = StatusModel.fromJson(jsonDecoded);
      return statusModel;
    } catch (e) {
      rethrow;
    }
  }
}
