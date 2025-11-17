import 'package:flutter/material.dart';

// 1. IMPORT YOUR NEW SPLASH SCREEN
import 'package:knock_to_know/features/knock_intro/introScreen.dart';
import 'package:knock_to_know/features/visual_identifier/camera_screen.dart';

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
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Plus Jakarta Sans'),
          displayMedium: TextStyle(fontFamily: 'Plus Jakarta Sans'),
          bodyLarge: TextStyle(fontFamily: 'Plus Jakarta Sans'),
          bodyMedium: TextStyle(fontFamily: 'Plus Jakarta Sans'),
        ),
      ),

      // 2. SET YOUR NEW 'home' SCREEN
      home: const CameraScreen(), // This was: const KnockScreen()

      // 3. (Optional) This removes the "DEBUG" banner from the corner
      debugShowCheckedModeBanner: false,
    );
  }
}