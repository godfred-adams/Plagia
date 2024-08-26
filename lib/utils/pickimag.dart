// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:ui';

import 'package:plagia_oc/screens/read_pdf.dart';

class PlagiaModel {
  final ImagePicker _picker = ImagePicker();

  Future<void> getImage({required BuildContext context}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    // Process the image
    await _processImage(image, context);
  }

  Future<void> _processImage(XFile image, BuildContext context) async {
    final InputImage inputImage = InputImage.fromFilePath(image.path);
    final TextRecognizer textRecognizer = GoogleMlKit.vision.textRecognizer();

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;

    textRecognizer.close();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReadPdf(content: text, fileName: "From OCR"),
      ),
    );
  }
}
