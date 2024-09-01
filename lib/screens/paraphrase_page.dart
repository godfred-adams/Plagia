import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:iconly/iconly.dart';

class ParaphrasePage extends StatefulWidget {
  const ParaphrasePage({super.key});

  @override
  State<ParaphrasePage> createState() => _ParaphrasePageState();
}

class _ParaphrasePageState extends State<ParaphrasePage> {
  // final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  bool _isLoading = false;
  final quill.QuillController _inputController = quill.QuillController.basic(
      configurations: const quill.QuillControllerConfigurations());

  Future<void> makePostRequest(String text) async {
    // final url =
    //     Uri.parse('https://ai-based-text-paraphrasing.p.rapidapi.com/data');
    // final headers = {
    //   'X-Rapidapi-Key': 'e782c3adc1msh044c312802562a8p1a5e11jsn85faffc9ff0d',
    //   'X-Rapidapi-Host': 'ai-based-text-paraphrasing.p.rapidapi.com',
    //   "Content-Type": "multipart/form-data",
    // };
    // final body = jsonEncode({'text': text});
    var url =
        Uri.parse('https://ai-based-text-paraphrasing.p.rapidapi.com/data');

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add headers
    request.headers.addAll({
      'X-Rapidapi-Key': 'd06041d5d0mshefe7116620f6b1fp173e62jsnba3d614d7357',
      'X-Rapidapi-Host': 'ai-based-text-paraphrasing.p.rapidapi.com',
      'Content-Type':
          'multipart/form-data; boundary=---011000010111000001101001',
    });

    // Add the text field to the request
    request.fields['text'] = text;
    setState(() {
      _isLoading = true;
    });

    try {
      // final response = await http.post(url, headers: headers, body: body);
      // debugPrint(await json.decode(response.body));
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      // print('Status code: ${response.statusCode}');
      // print('Response body: $responseString');
      if (response.statusCode == 200) {
        setState(() {
          _outputController.text = responseString;
        });
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _outputController.text = 'Request failed with error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff070c16),
        title: const Text(
          'Paraphrase',
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 15),
              // Row(
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       icon:
              //           const Icon(Icons.arrow_back_ios, color: Colors.orange),
              //     ),
              //     SizedBox(width: MediaQuery.of(context).size.width * 0.21),
              //     const Text(
              //       'Paraphrase',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 24,
              //       ),
              //     ),
              //     const Spacer(),
              //   ],
              // ),
              const SizedBox(height: 24),
              const Text(
                'Enter text to paraphrase',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // textAlign: TextAlign.left,
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
                      controller: _inputController,
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
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: quill.QuillEditor.basic(
                        controller: _inputController,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
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
                  onPressed: _isLoading
                      ? () {}
                      : () {
                          final text = _inputController.document.toPlainText();
                          if (text.isNotEmpty) {
                            print(text);
                            makePostRequest(text);
                          }
                        },
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Paraphrase',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Paraphrased Text',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _outputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Paraphrased text',
                ),
                maxLines: null,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
