import 'package:dio/dio.dart';
import '/data/user_data/data.dart';
import 'api/api.dart';

class UpdatePasswordRepository {
  AppData data = AppData();
  API api = API();

  // Future<List<TransactionsModel>> update() async {
  Future<dynamic> update(
      {required String new_password, required String old_password}) async {
    var body = {"OldPassword": "$old_password", "NewPassword": "$new_password"};

    // updateData(
    //                                 apiType: 'PUT',
    //                                 apiUrl:
    //                                     '$baseUrl/api/updatePassword/$userId?OldPassword=${current_password.text}&NewPassword=${new_password.text}');

    try {
      Response response =
          await api.sendRequest.put('/api/updatePassword/$user_id', data: body);

      return response.data;

      // List<dynamic> postMaps = response.data;
      // return postMaps
      //     .map((postMap) => TransactionsModel.fromJson(postMap))
      //     .toList();
    } catch (ex) {
      throw ex;
    }
  }
}
