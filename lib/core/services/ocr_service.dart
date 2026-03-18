import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

class OcrService {
  final TextRecognizer _recognizer = GoogleMlKit.vision.textRecognizer();

  Future<String?> extractTextFromImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText = await _recognizer.processImage(inputImage);
    return recognizedText.text.isNotEmpty ? recognizedText.text : null;
  }

  void dispose() {
    _recognizer.close();
  }
}
