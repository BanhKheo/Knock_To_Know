// import 'package:flutter/material.dart';
// import 'package:knock_to_know/features/visual_identifier/camera_screen.dart'; // <-- 1. IMPORT YOUR NEW SCREEN

// class KnockScreen extends StatelessWidget {
//   const KnockScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // 2. WRAP YOUR SCAFFOLD WITH A GESTUREDETECTOR
//     return GestureDetector(
//       onTap: () {
//         // 3. ADD THIS NAVIGATION LOGIC
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const CameraScreen()),
//         );
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xFFFFED5F),
//         body: Center(
//           child: Text(
//             '"KNOCK\nKNOCK"',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 40,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }