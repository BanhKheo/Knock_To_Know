import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

Future<Uint8List> preprocessImage(String imagePath, int inputSize) async {
  final File imageFile = File(imagePath);
  img.Image? oriImage = img.decodeImage(await imageFile.readAsBytes());
  img.Image resized = img.copyResize(oriImage!, width: inputSize, height: inputSize);
  // For float models, scale to 0..1 by dividing by 255.0 if needed (depending on your model training)
  return resized.getBytes();
}