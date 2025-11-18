// import 'dart:async'; // Import this for the Timer
// import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:knock_to_know/features/visual_identifier/camera_screen.dart'; // Import your camera screen

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   void _navigateToHome() {
//     // Wait for 4 seconds, then move to the next screen
//     Future.delayed(const Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const CameraScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFED5F),
//       body: Center(
//         child: AnimatedTextKit(
//           totalRepeatCount: 1,
//           animatedTexts: [
//             TyperAnimatedText(
//               '"KNOCK To\nKNOCK"',
//               textStyle: const TextStyle( 
//                 color: Colors.black,
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
              
//               speed: const Duration(milliseconds: 120),
//             ),
//           ],
//           isRepeatingAnimation: false,
//           onFinished: () {
//             // Ensure navigation occurs if animation finishes before the timer
//             if (mounted) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const CameraScreen()),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }