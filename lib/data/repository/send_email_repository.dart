import 'package:dio/dio.dart';
import '/data/user_data/data.dart';
import 'api/api.dart';

class SendEmailRepository {
  AppData data = AppData();
  API api = API();

  Future<dynamic> sendEmail(
      {required String fullName, required String email}) async {
    dynamic body = {"FullName": "$fullName", "Email": "$email"};
    try {
      Response response =
          await api.sendRequest.post('/api/userforgetpassword', data: body);
      return response.data;
    } catch (ex) {
      throw ex;
    }
  }
}
