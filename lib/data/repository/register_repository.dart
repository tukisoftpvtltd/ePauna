import 'dart:convert';

import 'package:dio/dio.dart';
import '/data/user_data/data.dart';
import '../models/register_model.dart';
import 'api/api.dart';

class RegisterRepository {
  AppData data = AppData();
  API api = API();

  Future<List<RegisterModel>> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String phone}) async {
    List<dynamic> res = [];
    dynamic body = {
      "FirstName": "$firstName",
      "LastName": "$lastName",
      "Email": "$email",
      "MobileNumber": "$phone",
      "Password": "$password"
    };
    try {
      Response response = await api.sendRequest.post(
          // '/api/user?FirstName=$firstName&LastName=$lastName&Email=$email&MobileNumber=$phone&Password=$password');
          '/api/user',
          data: body);

      res.add(jsonDecode(response.data));
      return res.map((val) => RegisterModel.fromJson(val)).toList();
    } catch (ex) {
      throw ex;
    }
  }
}
