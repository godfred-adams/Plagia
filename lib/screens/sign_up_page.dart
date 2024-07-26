
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

import '../widgets/build_light_theme_background.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/snacbar.dart';
import 'login_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});
  static const routeName = "/sign-up-screen";
  @override
  ConsumerState<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<SignUpPage> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void signUp() async {
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        nameController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty &&
        (passwordController.text.trim() ==
            confirmPasswordController.text.trim())) {
      try {
        setState(() {
          isLoading = true;
        });
        final authNotifier = ref.watch(authProvider.notifier);
        await authNotifier.signUp(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            context: context);

        showSnackBar(
            context: context,
            txt: 'Successful sign up \n login with the same credentials');
        emailController.text = "";
        passwordController.text = "";
        nameController.text = "";
        confirmPasswordController.text = "";
        setState(() {});
        Navigator.pushNamed(context, LoginPage.routeName);

        setState(() {
          isLoading = false;
        });
      } catch (err) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context: context, txt: err.toString());
      }
    } else {
      showSnackBar(
          context: context,
          txt: "Something went wrong check your credentials well");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          buildLightThemeBackground(
            mainWidget: Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create an account',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.orange),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      'Welcome! Enter your details to create a free account today.'),
                  const SizedBox(height: 30),

                  CustomTextField(
                    isPassword: false,
                    prefixIcon: Icons.person_outline_outlined,
                    hintText: 'Enter your full name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isPassword: false,
                    prefixIcon: Icons.mail,
                    hintText: 'Enter your email here',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isPassword: true,
                    prefixIcon: Icons.lock,
                    hintText: 'Enter your password here',
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isPassword: true,
                    prefixIcon: Icons.lock,
                    hintText: 'Confirm your password',
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: signUp,
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'or continue with',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Stack(alignment: Alignment.center, children: [
                  //   const Divider(
                  //     thickness: 3,
                  //     color: Colors.black,
                  //   ),
                  //   Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(22),
                  //       color: Colors.white,
                  //     ),
                  //     width: 104,
                  //     height: 24,
                  //     child: const Text(
                  //       'or continue',
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ]),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Image.asset(
                            'assets/images/google_icon.png',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Image.asset(
                            'assets/images/apple_icon.png',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const LoginPage()),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // context: context,
          // ),
          if (isLoading)
            Container(
              color: Colors.white.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  width: 50,
                  height: 50,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}




  // mainWidget: Padding(
  //   padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 18.0),
  //   child: Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Create an account',
  //         style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 24,
  //             color: Colors.orange),
  //       ),
  //       const SizedBox(height: 8),
  //       const Text(
  //           'Welcome! Enter your details to create a free account today.'),
  //       const SizedBox(height: 12),
  //       CustomTextField(
  //         controller: nameController,
  //         isPassword: false,
  //         prefixIcon: Icons.person_outline_outlined,
  //         hintText: 'Enter your name here',
  //       ),
  //       const SizedBox(height: 10),
  //       CustomTextField(
  //         controller: emailController,
  //         isPassword: false,
  //         prefixIcon: Icons.mail,
  //         hintText: 'Enter your email here',
  //       ),
  //       const SizedBox(height: 10),
  //       CustomTextField(
  //         controller: passwordController,
  //         isPassword: true,
  //         prefixIcon: Icons.lock,
  //         hintText: 'Enter your password here',
  //       ),
  //       const SizedBox(height: 10),
  //       CustomTextField(
  //         controller: confirmPasswordController,
  //         isPassword: true,
  //         prefixIcon: Icons.lock,
  //         hintText: 'Confirm your password',
  //       ),
  //       const SizedBox(height: 20),
  //       SizedBox(
  //         width: double.infinity,
  //         height: 50,
  //         child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Colors.orange,
  //           ),
  //           onPressed: signUp,
  //           child: const Text(
  //             'Signup',
  //             style: TextStyle(
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 18),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 30),
  //       Stack(alignment: Alignment.center, children: [
  //         const Divider(
  //           thickness: 3,
  //           color: Colors.black,
  //         ),
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(15),
  //             color: Colors.white,
  //           ),
  //           width: 104,
  //           height: 24,
  //           child: const Text(
  //             'or continue',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //       ]),
  //       const SizedBox(height: 30),
  //       GestureDetector(
  //         onTap: () {},
  //         child: buildContainer(
  //           'Google',
  //           'assets/images/g.png',
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       GestureDetector(
  //         onTap: () {},
  //         child: buildContainer(
  //           'Apple',
  //           'assets/images/a.png',
  //         ),
  //       ),
  //     ],
  //   ),
  // ),

  // );
