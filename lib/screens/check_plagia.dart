import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlagiarismResultScreen extends StatefulWidget {
  const PlagiarismResultScreen({super.key, required this.text});
  final String text;

  @override
  PlagiarismResultScreenState createState() => PlagiarismResultScreenState();
}

class PlagiarismResultScreenState extends State<PlagiarismResultScreen> {
  var res;
  quill.QuillController _controller = quill.QuillController.basic(
      configurations: const quill.QuillControllerConfigurations());

  Future<void> checkPlagiarism(String inputText) async {
    final url = Uri.parse('http://192.168.43.36:3000/check-plagiarism');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({"text": inputText});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // Process the response (e.g., show the result on the UI)
        print(jsonResponse);
      } else {
        print('Failed to check plagiarism: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> sendRequest() async {
    try {
      var url = Uri.parse(
          'https://plagiarism-source-checker-with-links.p.rapidapi.com/data');

      var request = http.MultipartRequest('POST', url);

      // Add text field
      request.fields['text'] =
          _controller.document.toPlainText().trim(); // Add your text here

      // Add headers
      request.headers.addAll({
        'X-Rapidapi-Key': '5a338886camshb631bbf8565d710p187680jsn84f113c8da2f',
        'X-Rapidapi-Host':
            'plagiarism-source-checker-with-links.p.rapidapi.com',
        'Content-Type': 'multipart/form-data',
      });

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Response: $responseData');
        setState(() {
          res = responseData;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    sendRequest();
    final doc = quill.Document()..insert(0, widget.text);
    _controller = quill.QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
    checkPlagiarism(_controller.document.toPlainText().trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plagiarism Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    // quill.QuillToolbar.simple(controller: _controller),
                    Container(
                      height: 350,
                      child: quill.QuillEditor.basic(
                        controller: _controller,
                        // true for view only mode
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Results",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildResultIndicator(
                    "Unique content",
                    0.28,
                    Colors.green,
                  ),
                  _buildResultIndicator(
                    "External content",
                    0.25,
                    Colors.red,
                  ),
                  _buildResultIndicator(
                    "AI generated",
                    0.47,
                    Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Sources",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "No sources found",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultIndicator(String label, double percentage, Color color) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 10.0,
          percent: percentage,
          center: Text(
            "${(percentage * 100).toInt()}%",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          progressColor: color,
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
