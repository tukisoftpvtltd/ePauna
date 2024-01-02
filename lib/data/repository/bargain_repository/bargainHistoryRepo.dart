import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/PlayerIdModel.dart';
import '../../models/bargain_history_model.dart';


class BargainHistoryRepository{
  Future< List<BargainHistoryModel>> getBargainHistory(String userId) async {
    try {
  
      var apiUrl = "https://pauna.tukisoft.com.np/api/pauna_bargain/$userId";
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      var data = jsonDecode(response.body);
      List jsonList =jsonDecode(response.body);
      print(data);
      // List<BargainHistoryModel> bargainHistory = BargainHistoryModel.fromJson(data).toList();
      List<BargainHistoryModel> bargainHistoryModel = jsonList.map((data) => BargainHistoryModel.fromJson(data)).toList();

      return bargainHistoryModel;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
