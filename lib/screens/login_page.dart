// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
// static const routeName = "/sign-in-screen";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:plagia_oc/bottom_nav_bar.dart';
import 'package:plagia_oc/screens/forgot_password_page.dart';
import '../../../utils/authentication.dart';
import 'package:plagia_oc/widgets/snacbar.dart';

// import '../providers/auth_provider.dart';
// import '../widgets/build_container.dart';

import '../widgets/build_light_theme_background.dart';
import '../widgets/custom_textfield.dart';

import 'sign_up_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  static const routeName = "/sign-in-screen";
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  Authentication authentication = Authentication();

  // Regular expression to validate email format
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void login() async {
    try {
      if (emailController.text.trim().isEmpty ||
          passwordController.text.trim().isEmpty) {
        showSnackBar(
          context: context,
          txt: "Email and Password cannot be empty.",
        );
        return;
      }

      // Validate the email format
      if (!emailRegex.hasMatch(emailController.text.trim())) {
        showSnackBar(
            context: context,
            txt: "Invalid email format. Please enter a valid email.");
      }

      setState(() {
        isLoading = true;
      });

      final res = await authentication.loginUser(
        passwordController.text.trim(),
        emailController.text.trim(),
        context,
      );

      if (res) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyBottomNavigation(),
          ),
        );
      } else {
        showSnackBar(
          context: context,
          txt:
              "Something went wrong. Check your network connection and try again.",
        );
      }
    } catch (er) {
      showSnackBar(context: context, txt: "Incorrect Email or Password!");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return buildLightThemeBackground(
      mainWidget: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.06),
              const Text(
                'Welcome back!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.orange),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your details to login to your account.',
                style: TextStyle(fontSize: 16.5),
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              CustomTextField(
                isPassword: false,
                prefixIcon: IconlyBroken.message,
                hintText: 'Enter your email here',
                controller: emailController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                isPassword: true,
                prefixIcon: IconlyBroken.lock,
                hintText: 'Enter your password here',
                controller: passwordController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          login();
                        },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                ),
              ),
              const SizedBox(height: 80),
              // const Center(
              //   child: Text(
              //     'or continue with',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
              // const SizedBox(height: 24),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () {},
              //       child: CircleAvatar(
              //         backgroundColor: Colors.grey.shade300,
              //         child: Image.asset(
              //           'assets/images/google.png',
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: 16),
              //     GestureDetector(
              //       onTap: () {},
              //       child: CircleAvatar(
              //         backgroundColor: Colors.grey.shade300,
              //         child: Image.asset(
              //           'assets/images/apple_logo.png',
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 16.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'SignUp',
                      style: TextStyle(
                          fontSize: 16.5,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// // static const routeName = "/sign-in-screen";
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:iconly/iconly.dart';
// import 'package:plagia_oc/bottom_nav_bar.dart';
// import 'package:plagia_oc/screens/forgot_password_page.dart';
// import '../../../utils/authentication.dart';
// import 'package:plagia_oc/widgets/snacbar.dart';

// // import '../providers/auth_provider.dart';
// // import '../widgets/build_container.dart';

// import '../widgets/build_light_theme_background.dart';
// import '../widgets/custom_textfield.dart';

// import 'sign_up_page.dart';

// class LoginPage extends ConsumerStatefulWidget {
//   const LoginPage({super.key});
//   static const routeName = "/sign-in-screen";
//   @override
//   ConsumerState<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends ConsumerState<LoginPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   bool isLoading = false;
//   Authentication authentication = Authentication();
//   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

//   void login() async {
//     try {
//       if (emailController.text.trim().isNotEmpty &&
//           passwordController.text.trim().isNotEmpty) {
//         setState(() {
//           isLoading = true;
//         });
//         final res = await authentication.loginUser(
//             passwordController.text.trim(),
//             emailController.text.trim(),
//             context);
//         if (res) {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MyBottomNavigation(),
//               ));
//           // Navigator.pushAndRemoveUntil(
//           // context, MaterialPageRoute(builder: (context)=> MyBottomNavigation(), Route<dynamic> route) => condition, ));
//         } else if (res == false) {
//           showSnackBar(
//               context: context,
//               txt:
//                   "Incorrect Email or Password. Kindly check your credentials");
//         } else {
//           // Handle a retrieve error from the database due to network issues
//           showSnackBar(
//               context: context,
//               txt: "Something went wrong check your network and try again");
//         }
//       } else {
//         showSnackBar(
//             context: context, txt: "Email and Password can not be empty");

//         return;
//       }
//       setState(() {
//         isLoading = false;
//       });
//     } catch (er) {
//       setState(() {
//         isLoading = false;
//       });
//       showSnackBar(context: context, txt: er.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return buildLightThemeBackground(
//       mainWidget: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: size.height * 0.06),
//               const Text(
//                 'Welcome back!',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 30,
//                     color: Colors.orange),
//               ),
//               const SizedBox(height: 8),
//               const Text('Enter your details to login to your account.',
//                   style: TextStyle(fontSize: 16.5)),
//               const SizedBox(height: 24),
//               const SizedBox(height: 24),
//               // const Text(
//               //   'Email',
//               //   style: TextStyle(
//               //     fontWeight: FontWeight.bold,
//               //     fontSize: 18,
//               //   ),
//               // ),
//               // SizedBox(height: 12),
//               CustomTextField(
//                 isPassword: false,
//                 prefixIcon: IconlyBroken.message,
//                 hintText: 'Enter your email here',
//                 controller: emailController,
//               ),
//               const SizedBox(height: 20),

//               // SizedBox(height: 12),
//               CustomTextField(
//                 isPassword: true,
//                 prefixIcon: IconlyBroken.lock,
//                 hintText: 'Enter your password here',
//                 controller: passwordController,
//               ),

//               Padding(
//                 padding: const EdgeInsets.only(top: 15.0),
//                 child: Align(
//                   alignment: Alignment.bottomRight,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ForgotPasswordScreen(),
//                         ),
//                       );
//                       const ForgotPasswordPage();
//                     },
//                     child: const Text(
//                       'Forgot your password?',
//                       style: TextStyle(
//                         color: Colors.orange,
//                         decorationColor: Colors.orange,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 height: 55,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: isLoading
//                       ? () {}
//                       : () async {
//                           login();
//                         },
//                   child: isLoading
//                       ? const Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : const Text(
//                           'Login',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const Center(
//                 child: Text(
//                   'or continue with',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               // Stack(alignment: Alignment.center, children: [
//               //   const Divider(
//               //     thickness: 3,
//               //     color: Colors.black,
//               //   ),
//               //   Container(
//               //     decoration: BoxDecoration(
//               //       borderRadius: BorderRadius.circular(22),
//               //       color: Colors.white,
//               //     ),
//               //     width: 104,
//               //     height: 24,
//               //     child: const Text(
//               //       'or continue',
//               //       style: TextStyle(fontWeight: FontWeight.bold),
//               //       textAlign: TextAlign.center,
//               //     ),
//               //   ),
//               // ]),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {},
//                     child: CircleAvatar(
//                       backgroundColor: Colors.grey.shade300,
//                       child: Image.asset(
//                         'assets/images/google.png',
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   GestureDetector(
//                     onTap: () {},
//                     child: CircleAvatar(
//                       backgroundColor: Colors.grey.shade300,
//                       child: Image.asset(
//                         'assets/images/apple_logo.png',
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Don\'t have an account?',
//                     style: TextStyle(
//                       fontSize: 16.5,
//                       // color: Colors.black,
//                       // fontWeight: FontWeight.bold
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: ((context) => const SignUpPage()),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       'SignUp',
//                       style: TextStyle(
//                           fontSize: 16.5,
//                           color: Colors.orange,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
