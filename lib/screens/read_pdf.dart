import 'package:flutter/material.dart';

class ReadPdf extends StatefulWidget {
  const ReadPdf({super.key, required this.content, required this.fileName});
  final String content;
  final String fileName;
  @override
  State<ReadPdf> createState() => _ReadPdfState();
}

class _ReadPdfState extends State<ReadPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    widget.content,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 18),
                  )),
                ),
              ),
            ),
          ),
        ));
  }
}
