// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plagia_oc/screens/read_pdf.dart';
import 'package:plagia_oc/widgets/build_light_theme_background.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:dotted_border/dotted_border.dart';

class PickUploadReadPdf extends StatefulWidget {
  const PickUploadReadPdf({super.key});

  @override
  PickUploadReadPdfState createState() => PickUploadReadPdfState();
}

class PickUploadReadPdfState extends State<PickUploadReadPdf> {
  String? filePath;
  String? pdfContent;
  bool isLoading = false;

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
    CollectionReference pdfs = FirebaseFirestore.instance.collection('pdfs');

    await pdfs.add({
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
    return buildLightThemeBackground(
      mainWidget: Column(
        children: [
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
                'Upload Files',
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (isLoading) const CircularProgressIndicator(),
              if (!isLoading) ...[
                DottedBorder(
                  borderType:
                      BorderType.RRect, // Use RRect for rounded rectangles
                  radius:
                      const Radius.circular(16), // Set the corner radius here
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
                              Icons.upload_file,
                              size: 100.0,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 24.0),
                            const Text(
                              'Upload your documents and photos here',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 32.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: GestureDetector(
                                onTap: pickPdf,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 45,
                                  width: double.infinity,
                                  child: const Center(
                                      child: Text(
                                    'Select a document',
                                    style: TextStyle(color: Colors.white),
                                  )),
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
    );
  }
}
