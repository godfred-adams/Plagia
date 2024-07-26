import 'package:flutter/material.dart';
import 'package:plagia_oc/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    // Ensure the duration matches the expected native splash screen duration
    await Future.delayed(
        const Duration(seconds: 3), () {}); // Delays for 3 seconds
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: Image(image: AssetImage("assets/images/splash_icon.png")),
      ),
    );
  }
}
