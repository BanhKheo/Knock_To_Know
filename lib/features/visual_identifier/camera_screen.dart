import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image_picker/image_picker.dart'; // <--- IMPORT THIS

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isBusy = false;
  String? _predictionResult;
  Interpreter? _interpreter;
  List<String> _labels = [];
  static const int imgSize = 100; 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
    _loadModel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the controller.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Re-initialize the camera when app is resumed
      _initializeCamera();
    }
  }

  // ... (Keep _loadModel, dispose, and _initializeCamera exactly as they were) ...
  Future<void> _loadModel() async {
    try {
      
      _interpreter = await Interpreter.fromAsset('assets/model.tflite');
      final labelsData = await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
      setState(() {
        _labels = labelsData.split('\n').map((e) => e.trim()).toList();
        _labels.removeWhere((label) => label.isEmpty);
      });
      print("Model and labels loaded!");
    } catch (e) {
      print("Failed to load model or labels: $e");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    _interpreter?.close();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameraStatus = await Permission.camera.request();
    if (cameraStatus.isDenied) return;
    if (cameraStatus.isPermanentlyDenied) { openAppSettings(); return; }

    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _controller = CameraController(
      cameras[0], 
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

  // --- 1. NEW FUNCTION: Pick from Gallery ---
  Future<void> _pickFromGallery() async {
    if (_isBusy) return;
    
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      // If user picked an image, run the exact same prediction logic
      await _processAndPredict(image);
    }
  }

  // --- 2. UPDATED FUNCTION: Capture from Camera ---
  Future<void> _captureAndPredict() async {
    if (_controller == null || !_controller!.value.isInitialized || _isBusy) {
      return;
    }
    
    try {
      final XFile picture = await _controller!.takePicture();
      await _processAndPredict(picture);
    } catch (e) {
      print("Camera error: $e");
    }
  }

  // --- 3. SHARED LOGIC: Process & Predict ---
  Future<void> _processAndPredict(XFile imageFile) async {
    // --- FIX START: Check if labels are loaded ---
    if (_labels.isEmpty) {
      print("⚠️ Error: Labels are not loaded yet! Please wait a moment.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loading AI model... please wait.')),
      );
      return;
    }
    // --- FIX END ---

    setState(() => _isBusy = true);

    try {
      final bytes = await imageFile.readAsBytes();
      img.Image? originalImage = img.decodeImage(bytes);

      if (originalImage == null) {
        print("Could not decode image");
        setState(() => _isBusy = false);
        return;
      }

      // Resize to 100x100
      img.Image resizedImage = img.copyResize(originalImage, width: imgSize, height: imgSize);

      // Convert to Input Array (Raw 0-255 values)
      var input = List.generate(1, (batch) {
        return List.generate(imgSize, (y) {
          return List.generate(imgSize, (x) {
            var pixel = resizedImage.getPixel(x, y);
            return [
              pixel.r.toDouble(), 
              pixel.g.toDouble(), 
              pixel.b.toDouble()
            ];
          });
        });
      });

      // Create output container
      // Since _labels is not empty now, this will work correctly (e.g., [1, 109])
      var output = List.filled(1, List.filled(_labels.length, 0.0));

      _interpreter!.run(input, output);

      List<double> outputList = List<double>.from(output[0]);
      double maxScore = outputList.reduce((a, b) => a > b ? a : b);
      int maxIndex = outputList.indexOf(maxScore);

      final pred = _labels[maxIndex];

      setState(() => _predictionResult = pred);
      _showBottomSheet(pred);

    } catch (e) {
      print("Prediction error: $e");
      // Print the labels length to debug
      print("Current labels count: ${_labels.length}"); 
      setState(() => _predictionResult = "Error");
    }
    
    setState(() => _isBusy = false);
  }

  void _showBottomSheet(String prediction) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.all(24),
        child: Text(
          'Prediction: $prediction',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
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
              padding: const EdgeInsets.only(top: 30.0 , left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(
                    'assets/icons/close_icon.svg',
                    () => Navigator.pop(context),
                  ),
                  _buildIconButton(
                    'assets/icons/flash_icon.svg',
                    () {},
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
            
            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // --- GALLERY BUTTON ---
                  _buildIconButton(
                    'assets/icons/gallery_icon.svg',
                    _pickFromGallery, // <--- CONNECTED HERE
                  ),
                  // --- CAMERA BUTTON ---
                  _buildIconButton(
                    'assets/icons/capture_icon.svg',
                    _captureAndPredict, // <--- CONNECTED HERE
                  ),
                  // --- SWITCH BUTTON ---
                  _buildIconButton(
                    'assets/icons/switch_camera_icon.svg',
                    () {},
                  ),
                ],
              ),
            ),
          ]), 
      );
  }

  Widget _buildIconButton(String assetPath, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(360),
        ),
        child: SvgPicture.asset(
          assetPath,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}