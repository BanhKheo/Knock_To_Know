import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Observe app lifecycle
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose(); // Dispose of the controller
    super.dispose();
  }

  // Handle app lifecycle changes (e.g., app paused/resumed)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null ||!_controller!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _controller!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera(); // Re-initialize camera when app resumes
    }
  }

  // Request permission and initialize the camera
  Future<void> _initializeCamera() async {
    // Request camera permission first
    final cameraStatus = await Permission.camera.request();
    
    if (cameraStatus.isDenied) {
      print("Camera permission denied");
      return;
    }
    if (cameraStatus.isPermanentlyDenied) {
      openAppSettings(); // Open app settings if permanently denied
      return;
    }

    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      print("No cameras available");
      return;
    }

    _controller = CameraController(
      cameras[0], // Use the back camera
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      setState(() {});
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(_controller!),
          _buildOverlayUI(),
        ],
      ),
    );
  }

  Widget _buildOverlayUI() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/picture/camera_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        // Top icons
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIconButton(
                'assets/icons/close_icon.svg',
                () => Navigator.pop(context),
              ),
              _buildIconButton(
                'assets/icons/flash_icon.svg',
                () {
                  // Toggle flash light
                },
              ),
            ],
          ),
        ),

        // Center content
        Column(
          children: [
            const Text(
              "\"WHO'S THERE?\"",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 250,
              width: 250,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.7), width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),

        // Bottom buttons
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton(
                'assets/icons/gallery_icon.svg',
                () {
                  // Take picture
                },
              ),
              _buildIconButton(
                'assets/icons/capture_icon.svg',
                () {
                  // Capture/record
                },
              ),
              _buildIconButton(
                'assets/icons/switch_camera_icon.svg',
                () {
                  // Switch camera
                },
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildIconButton(String assetPath, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(50),
        ),
        child: SvgPicture.asset(
          assetPath,
          width: 28,
          height: 28,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}