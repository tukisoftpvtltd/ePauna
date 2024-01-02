import 'package:flutter/material.dart';

class InternetErrorScreen extends StatelessWidget {
  const InternetErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Some Error Detected'),
      ),
    );
  }
}
