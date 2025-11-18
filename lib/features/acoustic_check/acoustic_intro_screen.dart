import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knock_to_know/features/acoustic_check/sound_check_screen.dart';

class AcousticIntroScreen extends StatelessWidget {
  // This screen will receive the fruit name from the camera screen
  final String fruitName;
  
  const AcousticIntroScreen({
    super.key,
    required this.fruitName,
  });

  @override
  Widget build(BuildContext context) {
    const Color darkBg = Color(0xFF2B2B2B);
    const Color lightText = Color(0xB3F5F5F5);
    const Color textColor = Color(0xFFF5F5F5); // Green

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- 1. Top Text ---
              Column(
                children: [
                  const Text(
                    "WATERMELON \n DETECTED",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Tap the screen to start the knock test $fruitName",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: lightText,
                      fontSize: 12,
                    ),
                  ),
                ],
                
              ),
              
              // --- 2. Center Icon ---
              SvgPicture.asset(
                'assets/icons/watermelon_detect_icon.svg',
                width: 200,
              ),

              // --- 3. Bottom Button & Text ---
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: textColor,
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SoundCheckScreen(fruitName: "watermelon"),
                        ),
                      );
                    },
                    child: const Text(
                      "KNOCK",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Ready? Knock on the watermelon to check its ripeness.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: lightText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}