import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart'; // static const routeName = "/sign-in-screen";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:plagia_oc/screens/login_page.dart';

// import '../providers/auth_provider.dart';

// import '../providers/auth_provider.dart';
import '../widgets/build_light_theme_background.dart';
import '../widgets/custom_textfield.dart';
import 'sign_up_page.dart';
import 'terms_and_conditions_page.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const routeName = "/forgot-password-screen";
  @override
  ConsumerState<ForgotPasswordScreen> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool _isChecked = false;
  bool isClearToSubmit = false;
  bool emptyController = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // final authNotifier = ref.read(authProvider.notifier);
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
                'Forgot Password? ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.orange),
              ),
              const SizedBox(height: 8),
              const Text(
                  'Don\'t worry! Please enter the email address linked to your account.',
                  style: TextStyle(fontSize: 16.5)),
              const SizedBox(height: 48),

              CustomTextField(
                onChanged: (txt) {
                  if (_isChecked & txt.isNotEmpty) {
                    setState(() {
                      isClearToSubmit = true;
                    });
                  }
                  if (_isChecked & txt.isEmpty) {
                    setState(() {
                      isClearToSubmit = false;
                    });
                  }
                  if (txt.isNotEmpty) {
                    setState(() {
                      emptyController = false;
                    });
                  }
                  if (txt.isEmpty) {
                    setState(() {
                      emptyController = true;
                    });
                  }
                },
                isPassword: false,
                prefixIcon: IconlyBroken.message,
                hintText: 'Enter your email here',
                controller: emailController,
              ),
              const SizedBox(height: 20),

              // SizedBox(height: 12),
              // CustomTextField(
              //   isPassword: true,
              //   prefixIcon: IconlyBroken.lock,
              //   hintText: 'Enter your password here',
              //   controller: passwordController,
              // ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 15.0),
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     child: GestureDetector(
              //       onTap: () {},
              //       child: const Text(
              //         'Forgot your password?',
              //         style: TextStyle(
              //           color: Colors.orange,
              //           decorationColor: Colors.orange,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16.0,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: size.height * 0.0227),
              Row(
                children: [
                  Checkbox(
                      value: _isChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isChecked = newValue ?? false;
                        });
                        if (!emptyController & _isChecked) {
                          setState(() {
                            isClearToSubmit = true;
                          });
                        }
                        if (!emptyController & !_isChecked) {
                          setState(() {
                            isClearToSubmit = false;
                          });
                        }
                      }),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsAndConditions()),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: 'I agree to the  ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: 'terms and conditions. ',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              )),
                        ],
                        // recognizer: TapGestureRecognizer()
                        //   ..onTap = () {
                        //     print("Terms and conditions tapped!");
                        //     // Navigate to terms and conditions page

                        //   },
                      ),
                    ),
                  ),
                ],
              ),
              // You could adjust the height dynamically
              SizedBox(height: size.height * 0.0341),
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
                  onPressed: () {},
                  // isLoading
                  //     ? () {}
                  //     : () async {
                  //         setState(() {
                  //           isLoading = true;
                  //         });
                  //         await authNotifier.loginUser(
                  //             email: emailController.text.trim(),
                  //             password: passwordController.text.trim(),
                  //             context: context);
                  //         setState(() {
                  //           isLoading = false;
                  //         });
                  //       },
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Verify Email',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              // const Center(
              //   child: Text(
              //     'or continue with',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //     textAlign: TextAlign.center,
              //   ),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Remembered Password?',
                    style: TextStyle(
                      fontSize: 16.5,
                    ),
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
                      'Log in',
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
