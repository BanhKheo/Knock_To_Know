import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knock_to_know/features/visual_identifier/camera_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFEEBD2B);

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header: logo + app name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //access logo svg
                  SvgPicture.asset(
                    'assets/icons/ripecheck_logo.svg',
                    width: 30,
                    height: 36,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "RipeCheck",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B180D),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Main content
              Column(
                children: [
                  const SizedBox(height: 16),
                  AnimatedTextKit(
                    totalRepeatCount: 3,
                    animatedTexts: [
                      TyperAnimatedText(
                        '"KNOCK To\nKNOCK"',
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 120),
                      ),
                    ],
                    isRepeatingAnimation: true,
                    pause: const Duration(milliseconds: 500), // Pause between repeats
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "The secret to perfect ripeness.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1B180D),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Footer button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF8F7F6),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Get Started"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}