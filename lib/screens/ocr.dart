import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plagia_oc/utils/pickimag.dart';
import 'package:plagia_oc/widgets/snacbar.dart';

import '../widgets/build_light_theme_background.dart';

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
    return buildLightThemeBackground(
      mainWidget: Column(children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.orange),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.33),
            const Text(
              'OCR Scan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 54),
        Center(
          child: Column(
            children: [
              DottedBorder(
                borderType:
                    BorderType.RRect, // Use RRect for rounded rectangles
                radius: const Radius.circular(16), // Set the corner radius here
                dashPattern: const [8, 4],
                color: Colors.orange,
                // strokeWidth: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 26),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 100.0,
                            color: Colors.black,
                          ),
                          SizedBox(height: 24.0),
                          Text(
                            'Upload your photos here',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 54),
              GestureDetector(
                onTap: pickAndRecognizeText,
                child: Stack(
                  alignment:
                      Alignment.center, // Align the containers to the center
                  children: [
                    // Outer container acting as the thick border
                    Container(
                      height: 86,
                      width: 86,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                    // Inner container
                    Container(
                      height: 62,
                      width: 62,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )

              // ElevatedButton(
              //     onPressed: pickAndRecognizeText,
              //     child: const Text("Pick an recogize read text on image")),
            ],
          ),
        ),
      ]),
    );

    // Scaffold(
    //   body: Center(
    //     child:
    // ElevatedButton(
    //         onPressed: pickAndRecognizeText,
    //         child: const Text("Pick an recogize read text on image")),
    //   ),
    // );
  }
}
