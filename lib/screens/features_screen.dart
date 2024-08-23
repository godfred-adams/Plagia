import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:plagia_oc/bottom_nav_bar.dart';
import 'package:plagia_oc/widgets/build_light_theme_background.dart';

import '../utils/navigation_provider.dart';
import '../widgets/build_icon_option.dart';
import '../widgets/build_modified_document_list.dart';
import 'ocr.dart';
import 'paraphrase_page.dart';
import 'pdf_test_page.dart';
import 'voice_to_text.dart';

class FeaturesScreen extends ConsumerStatefulWidget {
  const FeaturesScreen({super.key});
  static const routeName = "features-screen";

  @override
  ConsumerState<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends ConsumerState<FeaturesScreen> {
  List<Map<String, String>> featuresList = [
    {
      'title': 'Upload Docuument',
      'subtitle': 'Easily upload documents for analysis',
      'imageUrl': 'assets/images/file.png',
    },
    {
      'title': 'OCR',
      'subtitle':
          'Extract text from images effortlessly.\nPerfect for digitizing printed documents',
      'imageUrl': 'assets/images/scan.png',
    },
    {
      'title': 'Paraphrase',
      'subtitle':
          'Rephrase your text while retaining meaning.\nImprove clarity and avoid redundancy.',
      'imageUrl': 'assets/images/writing.png',
    },
    {
      'title': 'Speech/Text',
      'subtitle':
          'Convert speech into editable text.\nIdeal for creating notes and documents.',
      'imageUrl': 'assets/images/microphone.png',
    },
  ];

  void uploadDocument() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PickUploadReadPdf()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return buildLightThemeBackground(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.orange,
      //   onPressed: () {},
      //   child: Image.asset(
      //     'assets/images/mic.jpg',
      //     fit: BoxFit.cover,
      //   ),
      // ),
      mainWidget: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    ref.read(bottomNavIndexProvider.notifier).setIndex(0);
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.orange)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.25),
              const Text(
                'Features',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/card-pattern.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                  ),
                  Container(
                    width: double.infinity,
                    height: 180,
                    color: const Color(0xFF276817).withOpacity(0.9),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Plagiarism Check',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        // const Spacer(),
                        SizedBox(height: size.height * 0.018),
                        const Text(
                          'Accurately check your work for plagiarism. \nEnsure your content\'s originality and avoid unintentional plagiarism. \nAchieve academic integrity with confidence and produce work you can be proud of.',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: size.height * 0.012),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 6.0),
                        //   child: Align(
                        //       alignment: Alignment.bottomRight,
                        //       child: GestureDetector(
                        //         onTap: () {},
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //             color: Colors.orange,
                        //             borderRadius: BorderRadius.circular(6),
                        //           ),
                        //           height: 40,
                        //           width: 118,
                        //           child: const Center(
                        //               child: Text(
                        //             'Start Check',
                        //             style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.bold),
                        //           )),
                        //         ),
                        //       )),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.034),
          const Row(
            children: [
              Icon(IconlyBroken.category),
              SizedBox(width: 6),
              Text(
                'Features',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.012),
          SizedBox(
              width: double.infinity,
              height: 380,
              child: ListView(
                children: featuresList
                    .asMap() // Convert the list to a map to get index
                    .entries // Get the index and value pairs
                    .map((entry) {
                  int index = entry.key; // Get the index
                  Map<String, dynamic> item = entry.value; // Get the item
                  return GestureDetector(
                    onTap: () {
                      // Use a switch statement to determine which function to call based on the index
                      switch (index) {
                        case 0:
                          // Call function for first item (e.g., Upload Document)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PickUploadReadPdf()),
                          );
                          break;
                        case 1:
                          // Call function for second item (e.g., OCR)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Ocr()),
                          );
                          break;
                        case 2:
                          // Call function for third item (e.g., Paraphrase)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ParaphrasePage()),
                          );
                          break;
                        case 3:
                          // Call function for fourth item (e.g., Speech/Text)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VoiceToText()),
                          );
                          break;
                        default:
                          // Handle any other cases, if necessary
                          print('Unknown feature index: $index');
                      }
                    },
                    child: buildModifiedDocumentList(
                      item['imageUrl']!,
                      item['title']!,
                      item['subtitle']!,
                    ),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }

  Widget buildModifiedDocumentList(
      String imageUrl, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey.withOpacity(0.25),
        ),
        height: 82,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(width: 15),
          Image.asset(imageUrl, height: 55, width: 55),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
