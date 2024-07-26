import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadPdfToFirebase(String filePath) async {
  try {
    File file = File(filePath);
    String fileName = file.path.split('/').last;

    Reference storageReference =
        FirebaseStorage.instance.ref().child('pdfs/$fileName');

    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print("Error uploading PDF: $e");
    return null;
  }
}

Future<void> savePdfMetadata(
    String downloadURL, String fileName, String uid) async {
  CollectionReference pdfs =
      FirebaseFirestore.instance.collection("pdfs").doc(uid).collection('pdf');

  await pdfs.add({
    'url': downloadURL,
    'fileName': fileName,
    'uploadedAt': Timestamp.now(),
  });
}
