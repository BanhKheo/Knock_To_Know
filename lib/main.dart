import 'package:flutter/material.dart';

// 1. IMPORT YOUR SCREENS
import 'package:knock_to_know/features/splash_screen/splash_screen.dart';
import 'package:knock_to_know/features/knock_intro/knock_screen.dart';
import 'package:knock_to_know/features/ripeness_result/ripeness_result_screen.dart';

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

      // 2. SET 'home' TO YOUR SPLASH SCREEN
      home: const RipenessResultScreen(
            isRipe: true, 
            fruitName: "Avocado"
      ), // This screen will load first

      debugShowCheckedModeBanner: false,
    );
  }
}