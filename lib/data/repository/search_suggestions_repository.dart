import 'package:dio/dio.dart';
import '/data/user_data/data.dart';
import 'api/api.dart';

class SearchSuggestionsRepository {
  AppData data = AppData();
  API api = API();

  Future<dynamic> fetchSearchSuggestions({required String searchKey}) async {
    try {
      Response response =
          await api.sendRequest.get('/api/selectkeywordfromtable/$searchKey');
      return response.data;
    } catch (ex) {
      throw ex;
    }
  }
}
