import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:pdf_text/pdf_text.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ReadOnlinePdf extends StatefulWidget {
  const ReadOnlinePdf({
    super.key,
    required this.filename,
    required this.url,
  });

  final String filename;
  final String url;

  @override
  State<ReadOnlinePdf> createState() => _ReadOnlinePdfState();
}

class _ReadOnlinePdfState extends State<ReadOnlinePdf> {
  bool isLoading = true;
  String? pdfText;
  quill.QuillController _controller = quill.QuillController.basic();

  @override
  void initState() {
    super.initState();
    loadPdfFromFirebase();
  }

  Future<void> loadPdfFromFirebase() async {
    try {
      print(widget.url);
      final ref = FirebaseStorage.instance.refFromURL(widget.url);
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/${widget.filename}.pdf');

      await ref.writeToFile(file);
      //  final file = File(file.path);
      final bytes = await file.readAsBytes();
      final pdfDocument = PdfDocument(inputBytes: bytes);
      final text = PdfTextExtractor(pdfDocument).extractText();
      // PDFDoc pdfDoc = await PDFDoc.fromFile(file);
      // String text = await pdfDoc.text;

      setState(() {
        pdfText = text;
        _controller = quill.QuillController(
          document: quill.Document()..insert(0, pdfText!),
          selection: const TextSelection.collapsed(offset: 0),
        );
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filename),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (pdfText != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfTextEditor(
                      controller: _controller,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Expanded(
              child: quill.QuillEditor.basic(
                controller: _controller,
                // readOnly: false,
              ),
            ),
    );
  }
}

class PdfTextEditor extends StatelessWidget {
  final quill.QuillController controller;

  const PdfTextEditor({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit PDF Text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            quill.QuillSimpleToolbar(
              controller: controller,
              configurations: const quill.QuillSimpleToolbarConfigurations(
                showSuperscript: false,
                showSubscript: false,
                showFontSize: false,
                showFontFamily: false,
                showStrikeThrough: false,
                showInlineCode: false,
                showBackgroundColorButton: false,
                showClearFormat: false,
                showHeaderStyle: false,
                showColorButton: false,
                showListCheck: false,
                showQuote: false,
                showCodeBlock: false,
                showIndent: false,
              ),
            ),
            Expanded(
              child: quill.QuillEditor.basic(
                controller: controller,
                // readOnly: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
