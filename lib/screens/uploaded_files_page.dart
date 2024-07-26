import 'package:flutter/material.dart';

import '../widgets/build_modified_document_list.dart';
import 'check_plagiarism_page.dart';

class UploadedFilesPage extends StatelessWidget {
  const UploadedFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            'Uploaded Files',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'All Documents',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  // textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildModifiedDocumentList(),
                      buildModifiedDocumentList(),
                      buildModifiedDocumentList(),
                      buildModifiedDocumentList(),
                      buildModifiedDocumentList(),
                      buildModifiedDocumentList(),
                      buildModifiedDocumentList(),
                      buildModifiedDocumentList(),
                      buildModifiedDocumentList(),
                      buildModifiedDocumentList(),
                      buildModifiedDocumentList(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const CheckPlagiarismPage()),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 60,
                    color: Colors.black,
                    child: const Text(
                      'Bottom Navigation Bar here',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
