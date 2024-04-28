//import 'package:fingo_app/fingerprint.dart';
//import 'package:fingo_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fingo_app/splash_screen.dart'; // Import the Splash widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(), // Set SplashScreen as the initial route
    );
  }
}
