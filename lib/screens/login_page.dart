import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // static const routeName = "/sign-in-screen";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';

// import '../providers/auth_provider.dart';
// import '../widgets/build_container.dart';
import '../providers/auth_provider.dart';
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
  TextEditingController emailController =
      TextEditingController(text: "agyinjohn100@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "UZZIAHPOP");
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);
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
              const Text('Enter your details to login to your account.',
                  style: TextStyle(fontSize: 16.5)),
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              // const Text(
              //   'Email',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 18,
              //   ),
              // ),
              // SizedBox(height: 12),
              CustomTextField(
                isPassword: false,
                prefixIcon: IconlyBroken.message,
                hintText: 'Enter your email here',
                controller: emailController,
              ),
              const SizedBox(height: 20),

              // SizedBox(height: 12),
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
                    onTap: () {},
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Colors.orange,
                        decorationColor: Colors.orange,
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
                      ? () {}
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          await authNotifier.loginUser(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context);
                          setState(() {
                            isLoading = false;
                          });
                        },
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Login',
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
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 16.5,
                      // color: Colors.black,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const SignUpPage()),
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
