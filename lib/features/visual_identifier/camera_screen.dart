import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // 1. Get available cameras
    _cameras = await availableCameras();
    
    // --- FIX: Corrected the logical 'or' (||) operator ---
    if (_cameras == null || _cameras!.isEmpty) {
      print("No cameras found");
      return;
    }

    // 2. Initialize the controller with the first camera (usually the back camera)
    _controller = CameraController(
      _cameras![0], // Use the FIRST camera (back camera)
      ResolutionPreset.high,
      enableAudio: false, // We don't need audio from the camera
    );

    try {
      // 3. Wait for the controller to initialize
      await _controller!.initialize();
      // 4. Update the state to show the camera preview
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  // 5. IMPORTANT: Dispose of the controller when the widget is removed
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? Stack(
              fit: StackFit.expand,
              children: [
                // Camera preview
                CameraPreview(_controller!),
                // Overlay UI on top of camera
                _buildOverlayUI(),
              ],
            )
          : const Center(
              // Show a loading circle while the camera initializes
              child: CircularProgressIndicator(),
            ),
    );
  }

  // This builds the "WHO'S THERE?" text and icons
  Widget _buildOverlayUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Top icons
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Center Text: "WHO'S THERE?"
        const Text(
          "\"WHO'S\nTHERE?\"",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            // --- FIX: Added the list of shadows ---
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),

        // Empty container to push text up from the bottom
        Container(height: 100), 
      ],
    );
  }
}