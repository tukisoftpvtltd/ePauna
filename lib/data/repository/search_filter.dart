import 'package:dio/dio.dart';
import '../models/filter_model.dart';
import '/data/user_data/data.dart';
import 'api/api.dart';

class SearchFilterRepository {
  AppData data = AppData();
  API api = API();

  Future<List<FilterModel>> getSearchFilter(
    int index,
  ) async {
    try {
      Response response =
          await api.sendRequest.get('/api/serviceCategories/$index');
      print("Filter Response: ${response.data}");
      List<dynamic> filter = response.data;
      return filter.map((val) => FilterModel.fromJson(val)).toList();
    } catch (ex) {
      throw ex;
    }
  }
}
