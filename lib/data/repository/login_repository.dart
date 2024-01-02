import 'package:dio/dio.dart';
import '/data/user_data/data.dart';
import '../models/login_model.dart';
import 'api/api.dart';

class LoginRepository {
  AppData data = AppData();
  API api = API();

  Future<List<LoginModel>> login(
      {required dynamic email, required dynamic password}) async {
    List<dynamic> res = [];
    dynamic body = {"LoginEmail": "$email", "LoginPassword": "$password"};
    try {
      Response response =
          await api.sendRequest.post('/api/userlogin', data: body);

      res.add(response.data);

      return res.map((val) => LoginModel.fromJson(val)).toList();
    } catch (ex) {
      throw ex;
    }
  }
}
