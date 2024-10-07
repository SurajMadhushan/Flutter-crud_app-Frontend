import 'package:flutter/material.dart';
import 'dart:async'; // For timer

import './ui/screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen Demo',
      theme: ThemeData(
        primaryColor: Colors.blue[900], // Set primary color to dark blue
        scaffoldBackgroundColor: Colors.grey[200], // Light grey background for the app
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Set the splash screen timer to 3 seconds and navigate to the home screen
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Placeholder for your logo or image
            Icon(
              Icons.eco,
              size: 100,
              color: Colors.blue[900], // Dark blue icon for consistency
            ),
            SizedBox(height: 20),
            Text(
              'My Professional App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800], // Darker blue text
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200], // Light grey background
    );
  }
}
