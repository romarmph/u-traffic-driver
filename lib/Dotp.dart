import 'package:flutter/material.dart';

import 'config/themes/colors.dart';
import 'config/themes/spacing.dart';
import 'config/themes/textstyles.dart';

class DOtp extends StatefulWidget {
  const DOtp({super.key});

  @override
  State<DOtp> createState() => _DOtpState();
}

class _DOtpState extends State<DOtp> {
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
                  const SizedBox(height: USpace.space115),
                  Text(
                    'Forgot Password',
                    style: const UTextStyle().text4xlfontmedium.copyWith(
                          color: UColors.white,
                        ),
                  ),
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
            top: 240,
            left: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter OTP to verify',
                  style: const UTextStyle().textsmfontmedium.copyWith(
                        color: UColors.gray900,
                      ),
                ),
                const SizedBox(height: USpace.space8),
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: USpace.space8),
                    Container(
                      width: 55,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: USpace.space8),
                    Container(
                      width: 55,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:  const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: USpace.space8),
                    Container(
                      width: 55,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: USpace.space8),
                    Container(
                      width: 55,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: USpace.space8),
                    Container(
                      width: 55,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: USpace.space8),
              ],
            ),
          ),
          Positioned(
            top: 320,
            left: 0,
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
                    'Please enter to One Time Password (OTP) we’ve sent in your email or password to continue.',
                    textAlign: TextAlign.left,
                     style: const UTextStyle().textsmfontnormal.copyWith(
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
                        'Verify',
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
