import 'package:flutter/material.dart';

Widget buildLightThemeBackground({
  required Widget mainWidget,
  FloatingActionButton? floatingActionButton,
}) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: [
        // Background image with reduced opacity
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  const AssetImage('assets/images/ellipses_white_screen.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.27), // Adjust opacity here
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        // Main content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 3),
            child: mainWidget,
          ),
        ),
      ],
    ),
  );
}
//import 'package:flutter/material.dart';

// Widget buildLightThemeBackground({
//   required Widget mainWidget,
//   FloatingActionButton? floatingActionButton,
// }) {
//   return Scaffold(
//     extendBodyBehindAppBar: true,
//     resizeToAvoidBottomInset: false,
//     body: Stack(
//       children: [
//         Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/ellipses_white_screen.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(18, 18, 18, 3),
//             child: mainWidget,
//           ),
//         ),
//       ],
//     ),
//   );
// }
