// ignore_for_file: body_might_complete_normally_nullable, duplicate_ignore

import 'dart:convert';
import 'package:http/http.dart' as http;
import '/data/urls/urls.dart';
import '/data/models/model.dart';

import '../../data/models/select_room_model.dart';

class Services {
  // ignore: body_might_complete_normally_nullable
  Future<List<Model>?> getHotels({required String apiUrl}) async {
    var client = http.Client();
    var uri = Uri.parse(baseUrl + apiUrl);
    try {
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<Model> list = parseNewlyAdded(response.body);
        return list;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Model> parseNewlyAdded(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Model>((json) => Model.fromJson(json)).toList();
  }
}

// !Description services
class DescServices {
  Future<List<DescPics>?> descPics({required String apiUrl}) async {
    var client = http.Client();
    var uri = Uri.parse(baseUrl + apiUrl);

    try {
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<DescPics> list = parsedescPics(response.body);
        return list;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<DescPics> parsedescPics(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<DescPics>((json) => DescPics.fromJson(json)).toList();
  }
}

class SelectRoomServices {
  Future<List<SelectRoom>?> getRooms({required String apiUrl}) async {
    var client = http.Client();
    var uri = Uri.parse(baseUrl + apiUrl);
    try {
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<SelectRoom> list = parseNewlyAdded(response.body);
        return list;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<SelectRoom> parseNewlyAdded(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<SelectRoom>((json) => SelectRoom.fromJson(json)).toList();
  }
}
