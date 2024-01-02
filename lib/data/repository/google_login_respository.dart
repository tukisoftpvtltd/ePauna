import 'package:dio/dio.dart';
import '/data/user_data/data.dart';
import '../models/login_model.dart';
import 'api/api.dart';

class GoogleLoginRepository {
  AppData data = AppData();
  API api = API();

  Future<List<LoginModel>> googleLogin(
      {required dynamic firstName,
      required dynamic lastname,
      required dynamic email,
      required dynamic phone,
      required dynamic password}) async {
    List<dynamic> res = [];
    try {
      Response response = await api.sendRequest.post(
          '/api/userloginUsingGoogle?FirstName=$firstName&LastName=$lastname&Email=$email&MobileNumber=$phone&Password=$password');
      res.add(response.data);

      return res.map((val) => LoginModel.fromJson(val)).toList();
      // return response.data;
    } catch (ex) {
      throw ex;
    }
  }
}
