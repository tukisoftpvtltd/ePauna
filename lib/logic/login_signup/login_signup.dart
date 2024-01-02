import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignUp extends StatelessWidget {
  const LoginSignUp({
    super.key,
  });

  Future<dynamic> loginSignUpFunction(
      {required apiUrl, required String apiType}) async {
    var headersList = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(apiUrl);
    var req = http.Request(apiType, url);
    req.headers.addAll(headersList);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    final body = jsonDecode(resBody);
    print("The Login Response: $body");

    if (body["status"]) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("uid", body["UserId"]);
      return [body["status"], body["message"]];
    } else {
      return [body["status"], body["message"]];
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
