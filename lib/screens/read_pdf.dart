import 'package:flutter/material.dart';
import 'package:plagia_oc/screens/check_plagia.dart';
import 'package:plagia_oc/screens/check_plagiarism_page.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:http/http.dart' as http;

class ReadPdf extends StatefulWidget {
  const ReadPdf({
    super.key,
    required this.content,
    required this.fileName,
  });
  final String content;
  final String fileName;

  @override
  State<ReadPdf> createState() => _ReadPdfState();
}

class _ReadPdfState extends State<ReadPdf> {
  bool isLoading = false; // Loading state
  quill.QuillController _controller = quill.QuillController.basic(
      configurations: const quill.QuillControllerConfigurations());

  Future<void> sendRequest() async {
    try {
      setState(() {
        isLoading = true; // Show loading indicator when request starts
      });

      var url = Uri.parse(
          'https://plagiarism-source-checker-with-links.p.rapidapi.com/data');

      var request = http.MultipartRequest('POST', url);

      // Add headers
      request.headers.addAll({
        'X-Rapidapi-Key': 'your-api-key',
        'X-Rapidapi-Host':
            'plagiarism-source-checker-with-links.p.rapidapi.com',
        'Content-Type': 'multipart/form-data',
      });

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Response: $responseData');
        // Handle your response data here
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator when request completes
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final doc = quill.Document()..insert(0, widget.content);
    _controller = quill.QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.orange),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    Text(
                      widget.fileName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  "Text Editor",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      quill.QuillSimpleToolbar(
                        controller: _controller,
                        configurations:
                            const quill.QuillSimpleToolbarConfigurations(
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.60,
                        child: quill.QuillEditor.basic(
                          controller: _controller,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isLoading
                        ? () {}
                        : () async {
                            await sendRequest();

                            // Navigate to the PlagiarismResultScreen once done
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlagiarismResultScreen(
                                  text: widget.content,
                                ),
                              ),
                            );
                          },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Check plagiarism',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
