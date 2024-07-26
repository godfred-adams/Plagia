// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:ui';

import 'package:plagia_oc/screens/ocr_extract_page.dart';

class PlagiaModel {
  final ImagePicker _picker = ImagePicker();

  Future<void> getImage({required BuildContext context})async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    // Process the image
    await _processImage(image, context);
  }

  Future<void> _processImage(XFile image,BuildContext context ) async {
    final InputImage inputImage = InputImage.fromFilePath(image.path);
    final TextRecognizer textRecognizer = GoogleMlKit.vision.textRecognizer();

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    print("Recognized text: $text");
   
    // Process blocks of recognized text
    // for (TextBlock block in recognizedText.blocks) {
    //   final Rect rect = block.boundingBox;
    //   final String text = block.text;
    //   // final List<String> languages = block.recognizedLanguages;

    //   // Display the recognized text
    //   print("Block text: $text");

    //   // Display the bounding box
    //   print("Bounding Box: ${rect.toString()}");

    //   // Check if cornerPoints is available and print them
    //   final List<Offset> cornerPoints = block.cornerPoints
    //       .map((point) => Offset(point.x.toDouble(), point.y.toDouble()))
    //       .toList();
    //   print("Corner Points: $cornerPoints");
    // }

    textRecognizer.close();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> OcrExtractPage(txt: text) ));
  }
}
