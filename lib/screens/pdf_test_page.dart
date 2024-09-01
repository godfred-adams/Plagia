// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:plagia_oc/screens/read_pdf.dart';
import 'package:plagia_oc/utils/user_provider.dart';
import 'package:plagia_oc/utils/usermodel.dart';
import 'package:plagia_oc/widgets/build_light_theme_background.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:dotted_border/dotted_border.dart';

class PickUploadReadPdf extends ConsumerStatefulWidget {
  const PickUploadReadPdf({super.key});

  @override
  PickUploadReadPdfState createState() => PickUploadReadPdfState();
}

class PickUploadReadPdfState extends ConsumerState<PickUploadReadPdf> {
  UserModel? user;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).unfocus();
    // });
  }

  String? filePath;
  String? pdfContent;
  bool isLoading = false;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> pickPdf() async {
    setState(() {
      isLoading = true;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
      String? downloadURL = await uploadPdfToFirebase(filePath!);
      if (downloadURL != null) {
        String fileName = filePath!.split('/').last;
        await savePdfMetadata(downloadURL, fileName);
        pdfContent = await readPdf(filePath!);
        setState(() {});
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReadPdf(
                    fileName: filePath!.split("/").last,
                    content: pdfContent!,
                  )));
    } else {
      // User canceled the picker
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<String?> uploadPdfToFirebase(String filePath) async {
    try {
      File file = File(filePath);
      String fileName = file.path.split('/').last;

      Reference storageReference =
          FirebaseStorage.instance.ref().child('pdfs/$fileName');

      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      // print("Error uploading PDF: $e");
      return null;
    }
  }

  Future<void> savePdfMetadata(String downloadURL, String fileName) async {
    await FirebaseFirestore.instance
        .collection('pdfs')
        .doc(user!.uid)
        .collection('pdf')
        .doc(fileName)
        .set({
      'url': downloadURL,
      'fileName': fileName,
      'uploadedAt': Timestamp.now(),
    });
  }

  Future<String> readPdf(String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final pdfDocument = PdfDocument(inputBytes: bytes);
    final allText = PdfTextExtractor(pdfDocument).extractText();
    return allText ?? 'No text found in PDF';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff070c16),
        title: const Text(
          'Upload Document',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(IconlyBroken.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Row(
            //   children: [
            //     IconButton(
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //       icon: const Icon(Icons.arrow_back_ios, color: Colors.orange),
            //     ),
            //     SizedBox(width: MediaQuery.of(context).size.width * 0.23),
            //     const Text(
            //       'Upload Files',
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 18,
            //       ),
            //     ),
            //     const Spacer(),
            //   ],
            // ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.14),
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isLoading) const CircularProgressIndicator(),
                    if (!isLoading) ...[
                      DottedBorder(
                        borderType: BorderType
                            .RRect, // Use RRect for rounded rectangles
                        radius: const Radius.circular(
                            16), // Set the corner radius here
                        dashPattern: const [8, 4],
                        color: Colors.orange,
                        // strokeWidth: 6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 26),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: double.infinity,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    IconlyLight.paper_plus,
                                    size: 100.0,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 24.0),
                                  const Text(
                                    'Upload your documents here',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(height: 32.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 55,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed:
                                            pickPdf, // Call the dialog function
                                        child: const Text(
                                          'Select a document',
                                          style: TextStyle(
                                              color: Colors.white,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
