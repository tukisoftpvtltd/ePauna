import 'dart:convert';
import 'package:http/http.dart' as http;
import '/data/models/dynamic_services_model.dart';
import '/data/urls/urls.dart';

class DynamicServices {
  Future<List<DynamicServicesModel>?> getDynamicServices() async {
    var client = http.Client();
    var uri = Uri.parse(baseUrl + 'api/selectServiceProvidersByCategories');
    print("Complete Url: $baseUrl/api/selectServiceProvidersByCategories");
    try {
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<DynamicServicesModel> list = parseNewlyAdded(response.body);
        return list;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  static List<DynamicServicesModel> parseNewlyAdded(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<DynamicServicesModel>(
            (json) => DynamicServicesModel.fromJson(json))
        .toList();
  }
}
