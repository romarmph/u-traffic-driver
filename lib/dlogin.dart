import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'auth_service.dart';
import 'config/themes/colors.dart';
import 'config/themes/spacing.dart';
import 'config/themes/textstyles.dart';

class DLogin extends StatefulWidget {
  const DLogin({super.key});

  @override
  State<DLogin> createState() => _DLoginState();
}

class _DLoginState extends State<DLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isObscure = true;

  void loginBtnPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final authService = Provider.of<AuthService>(context, listen: false);
      final result = await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,

          child: Column(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 700,
                  height: 230,
                  color: UColors.blue700,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: USpace.space80),
                      Text(
                        'Sign in to your',
                        style: const UTextStyle().text4xlfontmedium.copyWith(
                              color: UColors.white,
                            ),
                      ),
                      Text(
                        'Account',
                        style: const UTextStyle().text4xlfontmedium.copyWith(
                              color: UColors.white,
                            ),
                      ),
                      Text(
                        'Login to continue',
                        style: const UTextStyle().textbasefontnormal.copyWith(
                              color: UColors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 260,
                left: 14,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: USpace.space10),
                      Text(
                        'Email or Phone number',
                        style: const UTextStyle().textsmfontmedium.copyWith(
                              color: UColors.gray900,
                            ),
                      ),
                      const SizedBox(height: USpace.space10),
        
                      Row(
                        children: [
                          // const Icon(Icons.email, color: UColors.gray400),
                          const SizedBox(width: USpace.space4),
                          Expanded(
                            child: TextFormField(
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return '*Required. Please enter an email address';
                              //   }
                              //   if (!EmailValidator.validate(value)) {
                              //     return 'Pleaser enter a valid email';
                              //   }
                              //   return null;
                              // },
        
                              // controller: emailController,
                              controller: _emailController,
        
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Enter your email ',
                                hintStyle: const UTextStyle()
                                    .textbasefontnormal
                                    .copyWith(
                                      color: UColors.gray500,
                                    ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
        
                      // const SizedBox(height: USpace.space4),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 260,
                left: 14,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: const UTextStyle().textsmfontmedium.copyWith(
                              color: UColors.gray900,
                            ),
                      ),
                      const SizedBox(height: USpace.space8),
                      Row(
                        children: [
                          const SizedBox(width: USpace.space10),
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.email, color: UColors.gray400),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                hintText: 'Enter your password',
                                hintStyle: const UTextStyle()
                                    .textbasefontnormal
                                    .copyWith(
                                      color: UColors.gray500,
                                    ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: USpace.space8),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 430,
                right: 16,
                child: TextButton(
                  onPressed: () {
                    // Implement your "Forgot Password" functionality
                  },
                  child: Text(
                    'Forgot Password?',
                    style: const UTextStyle().textbasefontmedium.copyWith(
                          color: UColors.blue700,
                        ),
                  ),
                ),
              ),
              Positioned(
                top: 474,
                left: 16,
                right: 16,
                child: Container(
                  width: 380,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => loginBtnPressed(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: UColors.blue700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: USpace.space8),
                          Text(
                            'Login',
                            style: const UTextStyle().textbasefontmedium.copyWith(
                                  color: UColors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 520,
                  left: 130,
                  child: Container(
                    decoration: const BoxDecoration(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Or Login With',
                          textAlign: TextAlign.left,
                          style: const UTextStyle().textbasefontnormal.copyWith(
                                color: UColors.gray400,
                              ),
                        ),
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SignInButton(
                      Buttons.google,
                      onPressed: () {},
                      text: 'Google',
                    ),
                  ),
                  const SizedBox(width: USpace.space8),
                  Container(
                    width: 120,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SignInButton(
                      Buttons.facebook,
                      onPressed: () {},
                      text: 'Facebook',
                    ),
                  ),
                ],
              ),
              const SizedBox(width: USpace.space8),
              Positioned(
                top: 700,
                left: 65,
                child: TextButton(
                  onPressed: () {
                    // Implement your "Forgot Password" functionality
                  },
                  child: Row(
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: const UTextStyle().textbasefontmedium.copyWith(
                              color: UColors.gray600,
                            ),
                      ),
                      Text(
                        'Register',
                        style: const UTextStyle().textbasefontmedium.copyWith(
                              color: UColors.blue700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
