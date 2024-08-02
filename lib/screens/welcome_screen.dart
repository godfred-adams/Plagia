import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:plagia_oc/screens/ocr.dart';
import 'package:plagia_oc/screens/paraphrase_page.dart';
import 'package:plagia_oc/screens/pdf_test_page.dart';
import 'package:plagia_oc/screens/voice_to_text.dart';
import 'package:plagia_oc/utils/user_provider.dart';

import 'package:plagia_oc/utils/usermodel.dart';
import 'package:plagia_oc/widgets/build_light_theme_background.dart';

import '../providers/auth_provider.dart';

import '../utils/navigation_provider.dart';
import '../widgets/build_icon_option.dart';
import '../widgets/build_modified_document_list.dart';
import 'login_page.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});
  static const routeName = "welcome-screen";

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool isLoading = false;
  UserModel? user;

  Future<void> loadUser() async {
    final loadedUser = await ref.read(userProvider.notifier).loadUser();
    debugPrint(loadedUser.toString());
    setState(() {
      user = loadedUser;
    });
    print(user);
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  String? filePath;

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userDetailsAsyncValue = ref.watch(userDetailsProvider);

    return buildLightThemeBackground(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
        child: Image.asset(
          'assets/images/mic.jpg',
          fit: BoxFit.cover,
        ),
      ),
      mainWidget: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              children: [
                            TextSpan(
                              text: 'Plagio',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Scope',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ])),
                      GestureDetector(
                        onTap: () async {
                          await ref.watch(authProvider.notifier).signOut();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginPage.routeName,
                            (T) => false,
                          );
                        },
                        child: const CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage('assets/images/per.png'),
                        ),
                      ),
                    ],
                  ),
                  //Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  if (user != null) ...[
                    Text(
                      'Welcome, ${user!.name}!',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ] else ...[
                    const Text(
                      'Loading user data...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],

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
                                  'Ensure originality with ease',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const Spacer(),
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    children: [
                                      TextSpan(
                                        text: 'Welcome to Plagio',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      TextSpan(
                                        text: 'Scope',
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                      TextSpan(
                                        text:
                                            '! Use our tools to check for plagiarism, transcribe speech, extract text from images, and paraphrase content.',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(bottomNavIndexProvider
                                                  .notifier)
                                              .setIndex(1);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          height: 35,
                                          width: 110,
                                          child: const Center(
                                              child: Text(
                                            'Start Check',
                                            style:
                                                TextStyle(color: Colors.white),
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
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PickUploadReadPdf())),
                        child: buildIconOption(
                            'assets/images/add_file.png', 'Upload Doc.'),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Ocr())),
                        child: buildIconOption('assets/images/ocr.png', 'OCR'),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ParaphrasePage())),
                        child: buildIconOption(
                            'assets/images/edit_text_file.png', 'Paraphrase'),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VoiceToText())),
                        child: buildIconOption(
                            'assets/images/speech_bubble.png', 'Speech/Text'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.history),
                      SizedBox(width: 6),
                      Text(
                        'Recent Activities',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildModifiedDocumentList(),
                          buildModifiedDocumentList(),
                          buildModifiedDocumentList(),
                          // buildModifiedDocumentList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );

    // Scaffold(
    //   extendBodyBehindAppBar: true,
    //   resizeToAvoidBottomInset: false,
    //   body:
    // );
  }
}
