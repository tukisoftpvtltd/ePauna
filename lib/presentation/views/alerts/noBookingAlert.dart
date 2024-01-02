import 'package:flutter/material.dart';
import 'package:ePauna/presentation/views/home_page/home.dart';

import '../../app_data/colors.dart';
import '../login_signup/login.dart';

class NoBookingAler extends StatefulWidget {
  const NoBookingAler({super.key});

  @override
  State<NoBookingAler> createState() => _NoBookingAlerState();
}

class _NoBookingAlerState extends State<NoBookingAler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
      ),
    );
  }
}
