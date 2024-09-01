// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import '../../../utils/authentication.dart';

// import '../providers/auth_provider.dart';

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
  Authentication authentication = Authentication();
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Regular expressions for validating email name and password
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
  final passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  void signUp() async {
    // print("sign up ......");
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        nameController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty) {
      // Check if the name contains numbers
      if (!nameRegex.hasMatch(nameController.text.trim())) {
        showSnackBar(
          context: context,
          txt: "Name can only contain alphabetic letters and spaces.",
        );
        return;
      }

      // Check if email format is valid
      if (!emailRegex.hasMatch(emailController.text.trim())) {
        showSnackBar(
          context: context,
          txt: "Invalid email format. Please enter a valid email address.",
        );
        return;
      }

      // Check if the password meets strength requirements
      if (!passwordRegex.hasMatch(passwordController.text.trim())) {
        showSnackBar(
          context: context,
          txt:
              "Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character.",
        );
        return;
      }

      // Check if passwords match
      if (passwordController.text.trim() !=
          confirmPasswordController.text.trim()) {
        showSnackBar(
          context: context,
          txt: "Passwords do not match. Please check and try again.",
        );
        return;
      }

      try {
        setState(() {
          isLoading = true;
        });
        final res = await authentication.signUp(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            context: context);
        if (res == "Successful") {
          showSuccessSnackBar(
              context: context,
              txt:
                  "Account created Sucessfully. \nKindly login with your email and password.");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
        setState(() {
          isLoading = false;
        });
      } catch (err) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context: context, txt: err.toString());
      }
    } else if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      showSnackBar(
        context: context,
        txt: "Input fields cannot be empty.",
      );
      return;
    } else {
      showSnackBar(
          context: context,
          txt:
              "Something went wrong. Check your network connection and try again");
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
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        buildLightThemeBackground(
          mainWidget: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.12),
                  const Text(
                    'Create an account',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.orange),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome! Enter your details to create a free account today.',
                    style: TextStyle(fontSize: 16.5),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    isPassword: false,
                    prefixIcon: IconlyBroken.profile,
                    hintText: 'Enter your full name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isPassword: false,
                    prefixIcon: IconlyBroken.message,
                    hintText: 'Enter your email here',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isPassword: true,
                    prefixIcon: IconlyBroken.lock,
                    hintText: 'Enter your password here',
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isPassword: true,
                    prefixIcon: IconlyBroken.lock,
                    hintText: 'Confirm your password',
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
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
                            fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 16.5),
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
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
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
        ),
        if (isLoading)
          Container(
            color: Colors.white.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                width: 50,
                height: 50,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          )
      ],
    );
  }
}
