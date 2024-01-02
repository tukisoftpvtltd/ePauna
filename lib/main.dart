import 'dart:io';

import 'package:ePauna/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import '/bloc/internet_bloc.dart';
import '/presentation/app_data/colors.dart';
import 'logic/routes/app_router.dart';
import 'presentation/views/utlis/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // String? token = await FirebaseMessaging.instance.getToken();
  String token = '';

  await FirebaseMessaging.instance.requestPermission().then((value) {
    Platform.isIOS
        ? FirebaseMessaging.instance.getAPNSToken().then((value) {
            print('Token $value');
            token = value.toString();
          })
        : FirebaseMessaging.instance.getToken().then((value) {
            print('Token $value');
            token = value.toString();
          });
  });
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInitializationSetting = DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: iosInitializationSetting);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print("The token value is" + token.toString());
  Platform.isIOS ? _checkLocationPermission() : () {};
  // print("the token is ");
  // print(token);
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  // OneSignal.shared.setAppId("35bb0d4c-a9e5-454d-a850-d994ec27d094");
  // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //   print("Accepted permission:$accepted");
  // });

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

Future<void> _checkLocationPermission() async {
  var status = await Permission.location.status;
  if (status.isDenied) {
    // Request location permission
    await Permission.location.request();
  } else if (status.isPermanentlyDenied) {
    // The user permanently denied the location permission
    // You may want to open the app settings so the user can manually enable it
    openAppSettings();
  }
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Builder(builder: (context) {
      return KhaltiScope(
          publicKey: 'test_public_key_31fcc2ac52e5486d8e36f522f9e099c7',
          enabledDebugging: true,
          builder: (context, navKey) {
            return BlocProvider(
              create: (context) => InternetBloc(),
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'ePauna',
                scrollBehavior: MyCustomScrollBehavior(),
                theme: ThemeData(
                  scaffoldBackgroundColor: appBackgroundColor,
                  primaryColor: mainColor,
                  fontFamily: "Poppins",
                ),
                onGenerateRoute: appRouter.onGenerateRoute,
                navigatorKey: navKey,
                localizationsDelegates: const [
                  KhaltiLocalizations.delegate,
                ],
              ),
            );
          });
    });
  }
}
