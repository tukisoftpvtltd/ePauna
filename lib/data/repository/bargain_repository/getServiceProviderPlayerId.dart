import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/PlayerIdModel.dart';


class getServiceProviderPlayerIdRepository {
  Future<PlayerIdModel> getServiceProviderPlayerId(String latitude ,String longitude) async {
    try {
  
      var apiUrl = "https://pauna.tukisoft.com.np/api/getServiceProviderPlayerIdList?latitude=$latitude&longitude=$longitude";
      // final Map<String, dynamic> data = {
      //   'user_id': userId,
      //   's_id': sid,
      // };
      // print(apiUrl);
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        // body: jsonEncode(data),
      );
      var data =jsonDecode(response.body);
      PlayerIdModel playerIdModel =  PlayerIdModel.fromJson(data);
      return playerIdModel;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
