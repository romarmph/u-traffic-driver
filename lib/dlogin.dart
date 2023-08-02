import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'config/themes/colors.dart';
import 'config/themes/spacing.dart';
import 'config/themes/textstyles.dart';

class DLogin extends StatefulWidget {
  const DLogin({super.key});

  @override
  State<DLogin> createState() => _DLoginState();
}

class _DLoginState extends State<DLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email or Phone number',
                  style: const UTextStyle().textsmfontmedium.copyWith(
                        color: UColors.gray900,
                      ),
                ),
                const SizedBox(height: USpace.space8),
                Container(
                  width: 365,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: UColors.gray50,
                    border: Border.all(
                      color: UColors.gray300,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.email, color: UColors.gray400),
                      const SizedBox(width: USpace.space10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your email or phone number here',
                            hintStyle:
                                const UTextStyle().textbasefontnormal.copyWith(
                                      color: UColors.gray500,
                                    ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: USpace.space8),
              ],
            ),
          ),
          Positioned(
            top: 357,
            left: 14,
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
                Container(
                  width: 365,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: UColors.gray50,
                    border: Border.all(
                      color: UColors.gray300,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.lock, color: UColors.gray400),
                      const SizedBox(width: USpace.space10),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter your password here',
                            hintStyle:
                                const UTextStyle().textbasefontnormal.copyWith(
                                      color: UColors.gray500,
                                    ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: USpace.space8),
              ],
            ),
          ),
          // ...

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
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Perform login action
                  },
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
              top: 540,
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
          Positioned(
            top: 600,
            right: 210,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
              ],
            ),
          ),

          Positioned(
            top: 600,
            right: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 120,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SignInButton(
                    Buttons.facebook,
                    onPressed: () {},
                    text: 'Facebook',
                  ),
                ),
                const SizedBox(width: USpace.space8),
              ],
            ),
          ),

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
    );
  }
}
