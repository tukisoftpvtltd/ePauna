// // ignore_for_file: unused_local_variable, deprecated_member_use

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:webview_flutter/webview_flutter.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key, required this.location}) : super(key: key);

//   final String location;

//   @override
//   _MapPagetate createState() => _MapPagetate();
// }

// class _MapPagetate extends State<MapPage> {
//   late WebViewController _webViewController;

//   // String testUrl = "https://pub.dev/packages/webview_flutter";

//   _loadHTMLfromAsset() async {
//     String file = await rootBundle.loadString("assets/maps/map.html");
//     _webViewController.loadUrl(Uri.dataFromString(file,
//             mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//         .toString());
//   }

//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       width: MediaQuery.of(context).size.width,
//       child: WebView(
//         zoomEnabled: true,
//         initialUrl: "about:blank",
//         javascriptMode: JavascriptMode.unrestricted,
//         javascriptChannels: Set.from([
//           JavascriptChannel(
//             name: "Success",
//             onMessageReceived: (message) {},
//           ),
//         ]),
//         onPageFinished: (data) {
//           String pid = UniqueKey().toString();
//           _webViewController
//               .evaluateJavascript('updateLocation("${widget.location}")');
//         },
//         onWebViewCreated: (webViewController) {
//           _webViewController = webViewController;
//           _loadHTMLfromAsset();
//         },
//       ),
//     );
//   }
// }
