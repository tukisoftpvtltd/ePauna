// https://pauna.tukisoft.com.np/api/GetIndividualSavedItems/p7FIZX2ODgKVFloOsiKh202303064007/3BqroNLdp8GTIT80EHk1202303027266

import 'dart:convert';

import 'package:dio/dio.dart';
import '/data/user_data/data.dart';
import 'api/api.dart';

class SaveServiceRepository {
  AppData data = AppData();
  API api = API();

  Future<bool> getSaveStatus({required dynamic s_id}) async {
    try {
      Response response = await api.sendRequest.get(
          // '/api/GetIndividualSavedItems/$user_id/3BqroNLdp8GTIT80EHk1202303027266');
          '/api/GetIndividualSavedItems/$user_id/$s_id');
      var data = jsonDecode(response.data);
      print("Saved Status is: ${data['status']}");
      return data['status'];
    } catch (ex) {
      throw ex;
    }
  }

  Future<bool> saveUnsaveService({required dynamic s_id}) async {
    try {
      var body = {
        'Sid': s_id,
        'UserId': user_id,
      };
      Response response =
          await api.sendRequest.post('/api/SaveServiceProvider', data: body);
      print("Save Operation Executed\nUserId: $user_id\nSid: $s_id");

      return true;
    } catch (ex) {
      throw ex;
    }
  }
}
