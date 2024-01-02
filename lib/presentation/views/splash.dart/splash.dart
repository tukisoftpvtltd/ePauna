// ignore_for_file: unused_import

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    Future<void> requestNotificationPermissions() async {
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus == AuthorizationStatus.authorized}'
  );
}
 LocationPermission permission = await Geolocator.checkPermission();
    try {
      print("The Permission is");
      print(permission);
      if (permission == LocationPermission.denied) {
        print("delete");
     
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request');
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
            Navigator.of(context).pushReplacementNamed('home');
       
      }
    } catch (e) {}
    // Future.delayed(const Duration(milliseconds: 1500), () {
      
     
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/pauna1-1.png'),
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.width * 0.17,
        ),
      ),
    );
  }
}
