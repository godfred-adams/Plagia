import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String txt}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      txt,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
  ));
}
