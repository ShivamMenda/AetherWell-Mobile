import 'package:flutter/material.dart';
import 'package:aetherwell/views/screens/splash_screen.dart';
import 'package:sizer/sizer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          home: SplashScreen(),
        );
      }
    );
  }
}

