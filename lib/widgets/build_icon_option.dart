import 'package:flutter/material.dart';

Widget buildIconOption(String imageUrl, String label) {
  const double cardSize = 82;
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 01,
                  blurRadius: 5,
                  offset: const Offset(0, 3)),
            ]),
        width: cardSize,
        height: cardSize,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
