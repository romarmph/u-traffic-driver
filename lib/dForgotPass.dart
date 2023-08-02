import 'package:flutter/material.dart';

import 'config/themes/colors.dart';
import 'config/themes/spacing.dart';
import 'config/themes/textstyles.dart';

class DVerification extends StatefulWidget {
  const DVerification({super.key});

  @override
  State<DVerification> createState() => _DVerificationState();
}

class _DVerificationState extends State<DVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 700,
              height: 200,
              color: UColors.blue700,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: USpace.space80),
                  Text(
                    'Forgot Password',
                    style: const UTextStyle().text4xlfontmedium.copyWith(
                          color: UColors.white,
                        ),
                  ),
                  const SizedBox(height: USpace.space8),
                  Text(
                    'Enter your email or phone number',
                    style: const UTextStyle().textbasefontnormal.copyWith(
                          color: UColors.white,
                        ),
                  ),
                  Text(
                    'to find your account',
                    style: const UTextStyle().textbasefontnormal.copyWith(
                          color: UColors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 210,
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
            top: 275,
            left: 10,
            child: Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: MediaQuery.of(context)
                  .size
                  .width, // Set container width to match the screen width
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'We will send you a One Time Password (OTP) once we find an account associated with your email or phone number.',
                    textAlign: TextAlign.left,
                    style: const UTextStyle().textxsfontnormal.copyWith(
                          color: UColors.gray500,
                        ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 680,
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
                    foregroundColor: UColors.white,
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
                        'Send OTP',
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
        ],
      ),
    );
  }
}
