// import 'package:flutter/material.dart';

// Widget buildLightThemeBackground(
//     {required AppBar appBar,
//     required Widget mainWidget,
//     required BuildContext context}) {
//   Size size = MediaQuery.of(context).size;
//   return Scaffold(
//       extendBodyBehindAppBar: true,
//       resizeToAvoidBottomInset: false,
//       appBar: appBar,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Stack(children: [
//             Container(
//                 decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                   'assets/images/ellipses_white_screen.png',
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             )),
//             Container(
//               height: size.height * 0.90,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//                   Colors.transparent,
//                   Colors.black.withOpacity(0.1),
//                 ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//               ),
//               child: mainWidget,
//             ),
//           ]),
//         ),
//       ));
// }
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
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ellipses_white_screen.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
          child: mainWidget,
        )),
      ],
    ),
    floatingActionButton: floatingActionButton,
  );
}
