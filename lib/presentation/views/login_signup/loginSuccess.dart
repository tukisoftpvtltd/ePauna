import 'package:flutter/material.dart';
import '../../../logic/google_login_api.dart';

class LoginSuccess extends StatefulWidget {
  const LoginSuccess({super.key, required this.data});
  final dynamic data;

  @override
  State<LoginSuccess> createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.data}'),
            ElevatedButton(
                onPressed: () async {
                  await LoginApi.signOut;
                  Navigator.pop(context);
                },
                child: Text('Sign Out')),
          ],
        ),
      ),
    );
  }
}
