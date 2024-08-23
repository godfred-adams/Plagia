// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';

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
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Check for empty fields and matching passwords
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword) {
      // Check if name contains only letters
      final namePattern = RegExp(r'^[a-zA-Z\s]+$');
      if (!namePattern.hasMatch(name)) {
        showSnackBar(
            context: context, txt: "Please enter a name with letters only.");
        return;
      }

      try {
        setState(() {
          isLoading = true;
        });
        final authNotifier = ref.watch(authProvider.notifier);
        await authNotifier.signUp(
            name: name, email: email, password: password, context: context);

        showSnackBar(
            context: context,
            txt: 'Successful sign up \n Login with the same credentials');
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
          txt: "Something went wrong, check your credentials.");
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
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'or continue with',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Image.asset(
                            'assets/images/google.png',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Image.asset(
                            'assets/images/apple_logo.png',
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
