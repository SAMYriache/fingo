import 'package:flutter/material.dart';
import 'package:fingo_app/fingerprint.dart'; // Import the fingerprint.dart file

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Wait for 4 seconds before navigating to the next page
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                 FingerprintRecognitionUI()), 
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313), // Set the background color
      body: Container(
        child: Center(
          child: Image.asset(
            'lib/assets/fingerprint.gif', // Replace with the correct path to the image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
