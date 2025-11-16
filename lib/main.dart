import 'package:flutter/material.dart';

// 1. IMPORT YOUR NEW SPLASH SCREEN
import 'package:knock_to_know/features/splash_screen/splash_screen.dart'; // Make sure this matches your project name

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
      ),

      // 2. SET YOUR NEW 'home' SCREEN
      home: const SplashScreen(), // This was: const KnockScreen()

      // 3. (Optional) This removes the "DEBUG" banner from the corner
      debugShowCheckedModeBanner: false,
    );
  }
}