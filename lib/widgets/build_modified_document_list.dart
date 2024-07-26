import 'package:flutter/material.dart';

Widget buildModifiedDocumentList() {
  return Column(
    children: [
      Card(
        color: Colors.white.withOpacity(0.8),
        child: ListTile(
          leading: Image.asset('assets/images/pdf.png'),
          // Icon(Icons.picture_as_pdf, color: Colors.red),
          title: const Text('doc'),
          subtitle: const Text(
            "1.5 MB - 13 January 2024, 17:00",
            style: TextStyle(fontSize: 14),
          ),
          trailing: const Icon(Icons.more_vert),
        ),
      ),
    ],
  );
}
