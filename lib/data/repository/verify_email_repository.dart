import 'package:dio/dio.dart';
import 'api/api.dart';

class EmailVerifyRepository {
  API api = API();

  Future<dynamic> verifyEmai({
    required String userId,
    required dynamic otp_code_1,
    required dynamic otp_code_2,
    required dynamic otp_code_3,
    required dynamic otp_code_4,
  }) async {
    try {
      Response response = await api.sendRequest.post(
          '/api/verifyUser?code1=$otp_code_1&code2=$otp_code_2&code3=$otp_code_3&code4=$otp_code_4&UserId=$userId');

      return response.data;
    } catch (ex) {
      throw ex;
    }
  }
}
