import 'package:flutter/material.dart';

Widget buildModifiedDocumentList({required filename, required date}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey.withOpacity(0.25),
      ),
      height: 78,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/pdf.png'),
            const SizedBox(width: 6),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Document name',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                Text(
                  '1.5 MB - 13 January 2024, 17:00',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.more_vert),
            const SizedBox(width: 6),
          ]),
    ),
  );
}
