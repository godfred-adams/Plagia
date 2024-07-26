import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ParaphrasePage extends StatefulWidget {
  const ParaphrasePage({super.key});

  @override
  State<ParaphrasePage> createState() => _ParaphrasePageState();
}

class _ParaphrasePageState extends State<ParaphrasePage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  bool _isLoading = false;

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
      appBar: AppBar(title: const Text('Paraphrase Text')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                textInputAction: TextInputAction.done,
                controller: _inputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text to paraphrase',
                ),
                maxLines: null,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        final text = _inputController.text;
                        if (text.isNotEmpty) {
                          makePostRequest(text);
                        }
                      },
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Paraphrase'),
              ),
              const SizedBox(height: 16.0),
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
