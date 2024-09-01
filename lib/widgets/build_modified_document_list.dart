import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

Future<void> deletePdf(String fileName) async {
  try {
    // Delete the file from Firebase Storage
    Reference storageReference =
        FirebaseStorage.instance.ref().child('pdfs/$fileName');
    await storageReference.delete();
    print('File deleted from storage.');

    // Delete the document reference from Firestore
    await FirebaseFirestore.instance
        .collection('pdfs')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('pdf')
        .doc(fileName)
        .delete();
    print('Document deleted from Firestore.');
  } catch (e) {
    print('Error deleting file: $e');
  }
}

Widget buildModifiedDocumentList(
    {required filename, required date, required BuildContext context}) {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    filename,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                _showDeleteConfirmationDialog(context, filename);
              },
              child: const Icon(
                IconlyBold.delete,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 6),
          ]),
    ),
  );
}

void _showDeleteConfirmationDialog(context, filename) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          'Confirm delete',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this file?',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              //         builder: (context) => const LoginPage())); //
            },
            child: InkWell(
              onTap: () async {
                await deletePdf(filename);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
