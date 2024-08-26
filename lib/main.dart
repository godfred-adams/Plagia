import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plagia_oc/screens/splash_screen.dart';
import 'package:plagia_oc/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_nav_bar.dart';
import 'firebase_options.dart';

import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: const Color(0xFF333333),
                displayColor: const Color(0xFF333333),
              ),
        ),
        useMaterial3: true,
        primaryColor: Colors.orange,
      ),
      home: FutureBuilder(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            return const MyBottomNavigation();
          } else {
            return const SplashScreen();
          }
        },
      ),
      // const Center(
      //   child: Text('data'),
      // ),
      // WelcomeScreen(),
      onGenerateRoute: (settings) => onGenerateRoute(settings),
    );
  }
}

Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isAuthenticated') ?? false;
}
