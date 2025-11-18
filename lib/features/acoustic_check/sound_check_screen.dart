import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundCheckScreen extends StatefulWidget {
  final String fruitName;

  const SoundCheckScreen({
    super.key,
    required this.fruitName,
  });

  @override
  State<SoundCheckScreen> createState() => _SoundCheckScreenState();
}

class _SoundCheckScreenState extends State<SoundCheckScreen> {
  @override
  void initState() {
    super.initState();
    _requestMicPermission();
  }

  // Request microphone permission when the screen loads
  Future<void> _requestMicPermission() async {
    final status = await Permission.microphone.request();
    if (status.isDenied) {
      print("Microphone permission denied");
    }
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  // Helper function to navigate to the results
  void _navigateToResult(bool isRipe) {
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ResultScreen(isRipe: isRipe),
    //   ),
    //   (route) => route.isFirst, // Go back to the FIRST screen in the stack (Camera)
    // );
  }

  @override
  Widget build(BuildContext context) {
    const Color darkBg = Color(0xFF2B2B2B);
    const Color lightText = Color(0xB3F5F5F5);
    const Color textColor = Color(0xFFF5F5F5); 
    const Color primaryColor = Color(0xFF4CAF50); // Green

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        title: const Text("Sound Check", textAlign: TextAlign.center, style: TextStyle(color: textColor , fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Make column just as tall as its children
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              // --- 1. Instruction Text ---
              Column(
                children: [
                  const Text(
                    "Ready to Record",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Tap the fruit gently near your phone's microphone.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: lightText,
                      fontSize: 15,
                    ),
                  ),
                ]
              ),

              const SizedBox(height: 70),

              // --- 2. Waveform (Static Placeholder) ---
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SvgPicture.asset(
                  'assets/icons/waveform.svg', // Placeholder for waveform
                  height: 100,
                  width: double.infinity,
                  colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                ),
              ),

              const SizedBox(height: 40),

              // --- 3. Timer & Mic Button ---
              Column(
                children: [
                  const Text(
                    "00:15",
                    style: TextStyle(
                      color: lightText,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      // Start/Stop recording logic here
                    },
                    child: const Icon(Icons.mic, size: 25, color: Colors.white),
                  ),
                ],
              ),
              
              // // --- 4. TEMPORARY SIMULATION BUTTONS (as requested) ---
              // Text(
              //   "--- Dev Only: Simulate Result ---",
              //   style: TextStyle(color: Colors.yellow),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}