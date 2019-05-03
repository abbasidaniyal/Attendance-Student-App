import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './home_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: Text(
        "Jamia Millia Islamia",
        style: TextStyle(fontSize: 30.0, color: Colors.green,fontWeight: FontWeight.bold),
      ),
      seconds: 2,
      loadingText: Text("Welcome"),
      navigateAfterSeconds: HomePage(),
      backgroundColor: Colors.white,
    );
  }
}
