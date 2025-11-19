import 'package:flutter/material.dart';
import 'package:knock_to_know/features/knock_intro/introScreen.dart';

// 1. IMPORT YOUR NEW SPLASH SCREEN
import 'package:knock_to_know/features/ripeness_result/ripeness_result_screen.dart'; // Make sure this matches your project name
import 'package:knock_to_know/features/ripeness_result/feedback_screen.dart'; // Make sure this matches your project name
import 'package:knock_to_know/features/acoustic_check/acoustic_intro_screen.dart';
import 'package:knock_to_know/features/visual_identifier/camera_screen.dart'; // Make sure this matches your project name   

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knock to Know',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'PlusJakartaSans', // Apply font globally
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontWeight: FontWeight.w900),
          bodyMedium: TextStyle(fontWeight: FontWeight.w900),
          bodySmall: TextStyle(fontWeight: FontWeight.w900),
        )
      ),

      // 2. SET YOUR NEW 'home' SCREEN
      home: const CameraScreen(), // Set SplashScreen as the home screen

      // 3. (Optional) This removes the "DEBUG" banner from the corner
      debugShowCheckedModeBanner: false,
    );
  }
}