import 'package:http/http.dart' as http;

Future<void> uploadPdf(String filePath) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('https://your-server.com/upload'),
  );

  request.files.add(await http.MultipartFile.fromPath('file', filePath));

  var response = await request.send();

  if (response.statusCode == 200) {
    print('Uploaded!');
  } else {
    print('Failed to upload');
  }
}
