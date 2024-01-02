import 'package:flutter/material.dart';

import '../../app_data/colors.dart';
import '../login_signup/login.dart';

class NotSignedIn extends StatelessWidget {
  const NotSignedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/no_booking.png"),
          Text(
            """Sign in or create an account to get started.""",
            textAlign: TextAlign.center,
          ),
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                  child: Text("Sign In")))
        ],
      ),
    );
  }
}
