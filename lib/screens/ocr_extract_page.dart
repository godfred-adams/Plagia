import 'package:flutter/material.dart';

class OcrExtractPage extends StatefulWidget {
  const OcrExtractPage({super.key, required this.txt});
  final String txt;
  @override
  State<OcrExtractPage> createState() => _OcrExtractPageState();
}

class _OcrExtractPageState extends State<OcrExtractPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    Center(child: Text(widget.txt))
    ],),);
  }
}