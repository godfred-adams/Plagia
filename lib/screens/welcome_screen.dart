import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:plagia_oc/screens/ocr.dart';
import 'package:plagia_oc/screens/paraphrase_page.dart';
import 'package:plagia_oc/screens/pdf_test_page.dart';
import 'package:plagia_oc/screens/voice_to_text.dart';
import 'package:plagia_oc/utils/pickimag.dart';
import 'package:plagia_oc/utils/user_provider.dart';

import 'package:plagia_oc/utils/usermodel.dart';
import 'package:plagia_oc/widgets/build_light_theme_background.dart';

import '../providers/auth_provider.dart';

import '../utils/navigation_provider.dart';
import '../widgets/build_icon_option.dart';
import '../widgets/build_modified_document_list.dart';
import '../widgets/snacbar.dart';
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
    // loadUser();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).unfocus();
    // });
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
    // final userDetailsAsyncValue = ref.watch(userDetailsProvider);
    final size = MediaQuery.of(context).size;

    return buildLightThemeBackground(
      mainWidget: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24.0),
                            children: [
                          TextSpan(
                            text: 'Plagio',
                            style: TextStyle(
                              color: Color(0xFF333333),
                            ),
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
                if (user != null) ...[
                  Text(
                    'Welcome, ${user!.name}!',
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ] else ...[
                  const Text(
                    'Loading user data...',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
                SizedBox(height: size.height * 0.012),
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
                                'Ensure originality with ease',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              // const Spacer(),
                              SizedBox(height: size.height * 0.015),

                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Welcome to Plagio',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Scope',
                                      style: GoogleFonts.poppins(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '! Use our tools to check for plagiarism, transcribe speech, extract text from images, and paraphrase content.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: size.height * 0.012),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(
                                                bottomNavIndexProvider.notifier)
                                            .setIndex(1);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        height: 40,
                                        width: 118,
                                        child: const Center(
                                            child: Text(
                                          'Start Check',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
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
                SizedBox(height: size.height * 0.028),
                const Row(
                  children: [
                    Icon(IconlyBroken.category),
                    SizedBox(width: 6),
                    Text(
                      'Features',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.008),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PickUploadReadPdf())),
                      child: buildIconOption(
                          'assets/images/add_file.png', 'Upload Doc.'),
                    ),
                    GestureDetector(
                      onTap: pickAndRecognizeText,
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => const Ocr())),
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
                SizedBox(height: size.height * 0.02),
                const Row(
                  children: [
                    Icon(IconlyBroken.times_quare),
                    SizedBox(width: 6),
                    Text(
                      'Recent Activities',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.008),
                Expanded(
                  child: SingleChildScrollView(
                    // physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        buildModifiedDocumentList(),
                        buildModifiedDocumentList(),
                        buildModifiedDocumentList(),
                        buildModifiedDocumentList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
