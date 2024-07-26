import 'package:flutter/material.dart';

Widget buildIconOption(String imageUrl, String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
      const SizedBox(height: 8),
      Text(
        label,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
