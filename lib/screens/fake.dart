// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:plagia_oc/screens/ocr.dart';
// import 'package:plagia_oc/screens/paraphrase_page.dart';
// import 'package:plagia_oc/screens/pdf_test_page.dart';
// import 'package:plagia_oc/screens/voice_to_text.dart';
// import 'package:plagia_oc/utils/user_provider.dart';

// import 'package:plagia_oc/utils/usermodel.dart';

// import '../providers/auth_provider.dart';

// import '../widgets/build_icon_option.dart';
// import '../widgets/build_modified_document_list.dart';
// import '../widgets/build_pinned_document.dart';
// import 'login_page.dart';

// class WelcomeScreen extends ConsumerStatefulWidget {
//   const WelcomeScreen({super.key});
//   static const routeName = "welcome-screen";

//   @override
//   ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
//   bool isLoading = false;
//   UserModel? user;

//   Future<void> loadUser() async {
//     final loadedUser = await ref.read(userProvider.notifier).loadUser();
//     debugPrint(loadedUser.toString());
//     setState(() {
//       user = loadedUser;
//     });
//     print(user);
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadUser();
//   }

//   String? filePath;

//   Future<void> pickPdf() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       setState(() {
//         filePath = result.files.single.path;
//       });
//     } else {
//       // User canceled the picker
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final userDetailsAsyncValue = ref.watch(userDetailsProvider);

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       resizeToAvoidBottomInset: false,
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator.adaptive(),
//             )
//           : SafeArea(
//               child: SingleChildScrollView(
//                 child: Stack(
//                   children: [
//                     Container(
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(
//                               'assets/images/ellipses_white_screen.png'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.transparent,
//                             Colors.black.withOpacity(0.3),
//                           ],
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(18.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 if (user != null) ...[
//                                   RichText(
//                                       text: const TextSpan(
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16),
//                                           children: [
//                                         TextSpan(
//                                           text: 'Plagio',
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                         TextSpan(
//                                           text: 'Scope',
//                                           style:
//                                               TextStyle(color: Colors.orange),
//                                         ),
//                                       ])),
//                                 ] else ...[
//                                   const Text(
//                                     'Loading user data...',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                                 GestureDetector(
//                                   onTap: () async {
//                                     await ref
//                                         .watch(authProvider.notifier)
//                                         .signOut();
//                                     Navigator.pushNamedAndRemoveUntil(
//                                       context,
//                                       LoginPage.routeName,
//                                       (T) => false,
//                                     );
//                                   },
//                                   child: const CircleAvatar(
//                                     radius: 24,
//                                     backgroundImage:
//                                         AssetImage('assets/images/per.png'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             Text(
//                               'Welcome, ${user!.name}!',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             // SizedBox(
//                             //   height: 45,
//                             //   width: double.infinity,
//                             //   child: TextField(
//                             //     decoration: InputDecoration(
//                             //       contentPadding: const EdgeInsets.symmetric(
//                             //         horizontal: 10.0,
//                             //         vertical: 8.0,
//                             //       ),
//                             //       filled: true,
//                             //       fillColor: Colors.grey[300],
//                             //       suffixIcon: const Icon(
//                             //         LineIcons.search,
//                             //       ),
//                             //       hintText: 'Search',
//                             //       border: OutlineInputBorder(
//                             //         borderRadius: BorderRadius.circular(15.0),
//                             //         borderSide: BorderSide.none,
//                             //       ),
//                             //     ),
//                             //   ),
//                             // ),
//                             const SizedBox(height: 12),
//                             const Row(
//                               children: [
//                                 Icon(Icons.add_box_outlined),
//                                 SizedBox(width: 6),
//                                 Text(
//                                   'Features',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () => Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const PickUploadReadPdf())),
//                                   child: buildIconOption(
//                                       'assets/images/add_file.png',
//                                       'Upload Doc.'),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () => Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => const Ocr())),
//                                   child: buildIconOption(
//                                       'assets/images/ocr.png', 'OCR'),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () => Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const ParaphrasePage())),
//                                   child: buildIconOption(
//                                       'assets/images/edit_text_file.png',
//                                       'Paraphrase'),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () => Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const VoiceToText())),
//                                   child: buildIconOption(
//                                       'assets/images/speech_bubble.png',
//                                       'Speech/Text'),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             // const Padding(
//                             //   padding: EdgeInsets.only(left: 10.0),
//                             //   child: Text(
//                             //     "Pinned 📌",
//                             //     style: TextStyle(
//                             //       fontSize: 20,
//                             //       color: Colors.black,
//                             //       fontWeight: FontWeight.w500,
//                             //     ),
//                             //   ),
//                             // ),
//                             // const SizedBox(height: 10),
//                             // SingleChildScrollView(
//                             //   scrollDirection: Axis.horizontal,
//                             //   child: Row(
//                             //     children: [
//                             //       buildPinnedDocument(
//                             //           'assets/images/pdf.png', 'Doc_1.pdf'),
//                             //       buildPinnedDocument(
//                             //           'assets/images/pdf.png', 'Doc_2.pdf'),
//                             //       buildPinnedDocument(
//                             //           'assets/images/pdf.png', 'Doc_3.pdf'),
//                             //       buildPinnedDocument(
//                             //           'assets/images/pdf.png', 'Doc_4.pdf'),
//                             //       buildPinnedDocument(
//                             //           'assets/images/pdf.png', 'Doc_5.pdf'),
//                             //     ],
//                             //   ),
//                             // ),
//                             const SizedBox(height: 12),
//                             const Row(
//                               children: [
//                                 Icon(Icons.history),
//                                 SizedBox(width: 6),
//                                 Text(
//                                   'Recent Activities',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                   ),
//                                 )
//                               ],
//                             ),

//                             SizedBox(
//                               width: double.infinity,
//                               height: 300,
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     buildModifiedDocumentList(),
//                                     buildModifiedDocumentList(),
//                                     buildModifiedDocumentList(),
//                                     // buildModifiedDocumentList(),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.orange,
//         onPressed: () {},
//         child: Image.asset(
//           'assets/images/mic.jpg',
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }
