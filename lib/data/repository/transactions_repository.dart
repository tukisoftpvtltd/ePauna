import 'package:dio/dio.dart';
import '/data/user_data/data.dart';
import 'api/api.dart';
import '/data/models/transactions.dart';

class TransactionsRepository {
  AppData data = AppData();
  API api = API();

  Future<List<TransactionsModel>> fetchTransactions() async {
    try {
      Response response =
          await api.sendRequest.get('/api/selectBookingsTransaction/$user_id');

      List<dynamic> postMaps = response.data;
      return postMaps
          .map((postMap) => TransactionsModel.fromJson(postMap))
          .toList();
    } catch (ex) {
      throw ex;
    }
  }
}
