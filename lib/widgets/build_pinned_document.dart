import 'package:flutter/material.dart';

Widget buildPinnedDocument(String imageUrl, String fileName) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[400],
          ),
          width: 64,
          height: 64,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          fileName,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
