// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ThemeNotifier extends ChangeNotifier {
//   bool _isDarkMode = false;
//   bool get isDarkMode => _isDarkMode;

//   ThemeData get currentTheme =>
//       _isDarkMode ? ThemeData.dark() : ThemeData.light();

//   void toggleTheme() {
//     _isDarkMode = !_isDarkMode;
//     notifyListeners();
//   }
// }

// final themeNotifierProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
//   return ThemeNotifier();
// });
