import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class QuillEditorExample extends StatefulWidget {
  @override
  _QuillEditorExampleState createState() => _QuillEditorExampleState();
}

class _QuillEditorExampleState extends State<QuillEditorExample> {
  quill.QuillController _controller = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Editor'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Handle saving the document
            },
          ),
        ],
      ),
      body: Column(
        children: [
          quill.QuillToolbar.simple(controller: _controller),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: quill.QuillEditor.basic(
                controller: _controller,
                // set to true for view-only mode
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: QuillEditorExample()));
}
