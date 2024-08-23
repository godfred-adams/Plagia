import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Terms and Conditions',
      home: Scaffold(
        body: Center(
          child: Text('Terms and conditions here'),
        ),
      ),
    );
  }
}
