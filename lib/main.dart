import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plagia_oc/screens/welcome_screen.dart';
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
        fontFamily: "Montserrat",
        useMaterial3: true,
      ),
      home: const MyBottomNavigation(),
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
  return prefs.getBool('isAthenticated') ?? false;
}


//  FutureBuilder(
//           future: checkLoginStatus(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasData && snapshot.data == true) {
//               return const WelcomeScreen();
//             } else if (!snapshot.hasData && snapshot.data == false) {
//               return const WelcomeScreen();
//             } else {
//               return const WelcomeScreen();
//             }
//           })