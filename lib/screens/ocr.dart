import 'package:flutter/material.dart';
import 'package:plagia_oc/utils/pickimag.dart';
import 'package:plagia_oc/widgets/snacbar.dart';

class Ocr extends StatefulWidget {
  const Ocr({super.key});

  @override
  State<Ocr> createState() => _OcrState();
}

class _OcrState extends State<Ocr> {
  PlagiaModel plagiaModel = PlagiaModel();

  void pickAndRecognizeText() async {
    try {
      await plagiaModel.getImage(context: context);
    } catch (er) {
      debugPrint(er.toString());
      showSnackBar(context: context, txt: er.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: pickAndRecognizeText,
            child: const Text("Pick an recogize read text on image")),
      ),
    );
  }
}
