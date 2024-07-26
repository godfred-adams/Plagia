// import 'package:flutter/material.dart';

// import 'package:plag_app/screens/sign_up_page.dart';
// import 'package:plag_app/screens/welcome_screen.dart';
// import 'package:plag_app/widgets/build_container.dart';

// import '../widgets/custom_textfield.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ShaderMask(
//           blendMode: BlendMode.lighten,
//           shaderCallback: (bounds) => const LinearGradient(
//             colors: [
//               Colors.white,
//               Colors.white70,
//               // Colors.black87,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomCenter,
//           ).createShader(bounds),
//           child: Container(
//               decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/ellipses_white_screen.png'),
//               filterQuality: FilterQuality.high,
//               fit: BoxFit.cover,
//             ),
//           )),
//         ),
//         Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//           ),
//           backgroundColor: Colors.transparent,
//           body: SafeArea(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//                   Colors.transparent,
//                   Colors.black.withOpacity(0.3),
//                 ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // const SizedBox(height: 12),
//                     const Text(
//                       'Log in to your account',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 24,
//                           color: Colors.orange),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                         'Welcome back! Enter your details to login to your account.'),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'Email',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     // SizedBox(height: 12),
//                     const CustomTextField(
//                       isPassword: false,
//                       prefixIcon: Icons.mail,
//                       hintText: 'Enter your email here',
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'Password',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     // SizedBox(height: 12),
//                     const CustomTextField(
//                       isPassword: true,
//                       prefixIcon: Icons.lock,
//                       hintText: 'Enter your password here',
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: const Text(
//                         'Forgot your password?',
//                         style: TextStyle(
//                           color: Colors.orange,
//                           decoration: TextDecoration.underline,
//                           decorationColor: Colors.orange,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     // const SizedBox(height: 12),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 60,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(22),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const WelcomeScreen()),
//                           );
//                         },
//                         child: const Text(
//                           'Login',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Stack(alignment: Alignment.center, children: [
//                       const Divider(
//                         thickness: 3,
//                         color: Colors.black,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(22),
//                           color: Colors.white,
//                         ),
//                         width: 104,
//                         height: 24,
//                         child: const Text(
//                           'or continue',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ]),
//                     const SizedBox(height: 36),
//                     GestureDetector(
//                       onTap: () {},
//                       child: buildContainer(
//                         'Google',
//                         'assets/images/google_icon.png',
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     GestureDetector(
//                       onTap: () {},
//                       child: buildContainer(
//                         'Apple',
//                         'assets/images/apple_icon.png',
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Don\'t have an account?',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: ((context) => const SignUpPage()),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             'SignUp',
//                             style: TextStyle(
//                               color: Colors.orange,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
