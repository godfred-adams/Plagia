import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      'imageUrl': 'assets/images/add_file.png',
    },
    {
      'title': 'OCR',
      'subtitle':
          'Extract text from images effortlessly.\nPerfect for digitizing printed documents',
      'imageUrl': 'assets/images/ocr.png',
    },
    {
      'title': 'Paraphrase',
      'subtitle':
          'Rephrase your text while retaining meaning.\nImprove clarity and avoid redundancy.',
      'imageUrl': 'assets/images/edit_text_file.png',
    },
    {
      'title': 'Speech/Text',
      'subtitle':
          'Convert speech into editable text.\nIdeal for creating notes and documents.',
      'imageUrl': 'assets/images/speech_bubble.png',
    },
  ];

  void uploadDocument() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PickUploadReadPdf()));
  }

  @override
  Widget build(BuildContext context) {
    return buildLightThemeBackground(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
        child: Image.asset(
          'assets/images/mic.jpg',
          fit: BoxFit.cover,
        ),
      ),
      mainWidget: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        ref.read(bottomNavIndexProvider.notifier).setIndex(0);
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.orange)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.33),
                  const Text(
                    'Features',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/card-pattern.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 160,
                      ),
                      Container(
                        width: double.infinity,
                        height: 160,
                        color: Colors.lightGreen.withOpacity(0.9),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Plagiarism Check',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const Spacer(),
                            const Text(
                              'Accurately check your work for plagiarism. \nEnsure your content\s originality and avoid unintentional plagiarism.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    // onTap: () {
                                    //   Navigator.pushNamed(
                                    //       context, FeaturesScreen.routeName);
                                    // },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      height: 35,
                                      width: 110,
                                      child: const Center(
                                          child: Text(
                                        'Start Check',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.add_box_outlined),
                  SizedBox(width: 6),
                  Text(
                    'Features',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                  width: double.infinity,
                  height: 350,
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
                                    builder: (context) =>
                                        const ParaphrasePage()),
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
        ),
      ),
    );
    // Scaffold(
    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: Colors.orange,
    //     onPressed: () {},
    //     child: Image.asset(
    //       'assets/images/mic.jpg',
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   extendBodyBehindAppBar: true,
    //   resizeToAvoidBottomInset: false,
    //   body:

    // );
  }

  Widget buildModifiedDocumentList(
      String imageUrl, String title, String subtitle) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            color: Colors.white.withOpacity(0.8),
            child: ListTile(
              leading: Image.asset(imageUrl),
              title: Text(title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text(
                subtitle,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
