import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:u_traffic_driver/config/device/device_constraint.dart';
import 'package:u_traffic_driver/Dinfo.dart';
import 'package:u_traffic_driver/dlogin.dart';
import 'package:u_traffic_driver/model/driver_model.dart';
import 'package:u_traffic_driver/provider/driver_provider.dart';

import 'config/themes/colors.dart';
import 'config/themes/spacing.dart';
import 'config/themes/textstyles.dart';

class DRegister extends StatefulWidget {
  const DRegister({super.key});

  @override
  State<DRegister> createState() => _DRegisterState();
}

class _DRegisterState extends State<DRegister> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();
  // final firstNameController = TextEditingController();
  // final middleNameController = TextEditingController();
  // final lastNameController = TextEditingController();
  // TextEditingController _birthdateController = TextEditingController();
  // final idController = TextEditingController();

  var obscurePassword = true;

  final _formkey = GlobalKey<FormState>();

  // final collectionPath = 'driversRegisterInfo';

  void registerClient() async {
    try {
      EasyLoading.show(
        status: 'Proccesing...',
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final driverProvider = Provider.of<DriverProvider>(context);

      driverProvider.updateDriver(Driver(
        firstName: "",
        middleName: "",
        lastName: "",
        birthDate: "",
        email: emailController.text,
        phone: "",
        password: passwordController.text,
      ));
      

      // String uid = userCredential.user!.uid;
      // await FirebaseFirestore.instance.collection(collectionPath).doc(uid).set({
      //   'id': 'null/test',
      //   // 'firstName': firstNameController.text,
      //   // 'middleName': middleNameController.text,
      //   // 'lastName': lastNameController.text,
      //   // 'birthDate': _birthdateController.text,
      //   'email': emailController.text,
      //   'password': passwordController.text,
      // });

      EasyLoading.showSuccess('User account has been registered.');
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        EasyLoading.showError(
            'Your password is weak. Please enter more than 6 characters.');
        return;
      }
      if (ex.code == 'email-already-in-use') {
        EasyLoading.showError(
            'Your email has already taken. Please enter another email address.');
        return;
      }
      if (ex.code == 'null-credential') {
        EasyLoading.showError(
            'An error eccoured while creating your account. Please try again');
      }
      print(ex.code);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => Dinfo()));
  }

  void validateInput() {
    if (_formkey.currentState!.validate()) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          text: null,
          title: 'Are you sure?',
          confirmBtnText: 'YES',
          cancelBtnText: 'NO',
          onConfirmBtnTap: () {
            Navigator.pop(context);
            registerClient();
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = deviceHeight(context);
    final double width = deviceWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
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
                        const SizedBox(height: USpace.space135),
                        Text(
                          'Register',
                          style: const UTextStyle().text4xlfontmedium.copyWith(
                                color: UColors.white,
                              ),
                        ),
                        Text(
                          'Create your Account',
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
                        // Container(
                        //   width: 365,
                        //   height: 44,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8),
                        //     color: UColors.gray50,
                        //     border: Border.all(
                        //       color: UColors.gray300,
                        //       width: 1,
                        //     ),
                        //   ),
                        //   padding: const EdgeInsets.symmetric(horizontal: 16),
                        //   child: Row(
                        //     children: [
                        //       // const Icon(Icons.email, color: UColors.gray400),
                        //       const SizedBox(width: USpace.space10),
                        //       Expanded(
                        //         child: TextFormField(
                        //           validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return '*Required. Please enter an email address';
                        //     }
                        //     if (!EmailValidator.validate(value)) {
                        //       return 'Pleaser enter a valid email';
                        //     }
                        //     return null;
                        //   },
                        //   controller: emailController,

                        //           decoration: InputDecoration(
                        //             prefixIcon: Icon(Icons.email, color: UColors.gray400),
                        //             hintText: 'Enter your email or phone number here',
                        //             hintStyle:
                        //                 const UTextStyle().textbasefontnormal.copyWith(
                        //                       color: UColors.gray500,
                        //                     ),
                        //             border: InputBorder.none,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Row(
                          children: [
                            // const Icon(Icons.email, color: UColors.gray400),
                            const SizedBox(width: USpace.space4),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '*Required. Please enter an email address';
                                  }
                                  if (!EmailValidator.validate(value)) {
                                    return 'Pleaser enter a valid email';
                                  }
                                  return null;
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  prefixIcon: Icon(Icons.email),
                                  hintText:
                                      'Enter your email or phone number here',
                                  hintStyle: const UTextStyle()
                                      .textbasefontnormal
                                      .copyWith(
                                        color: UColors.gray500,
                                      ),
                                ),
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
                  top: 340,
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
                        const SizedBox(height: USpace.space10),
                        // Container(
                        //   width: 365,
                        //   height: 44,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8),
                        //     color: UColors.gray50,
                        //     border: Border.all(
                        //       color: UColors.gray300,
                        //       width: 1,
                        //     ),
                        //   ),
                        //   padding: const EdgeInsets.symmetric(horizontal: 16),
                        //   child: Row(
                        //     children: [
                        //       const Icon(Icons.lock, color: UColors.gray400),
                        //       const SizedBox(width: USpace.space10),
                        //       Expanded(
                        //         child: TextFormField(
                        //           validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return '*Required. Please enter your password';
                        //     }
                        //     if (!RegExp(r'^[a-zA-Z0-9]+$')
                        //         .hasMatch(passwordController.text)) {
                        //       return 'Password must contain letters and numbers.';
                        //     }

                        //     return null;
                        //   },

                        //   controller: passwordController,

                        //           obscureText: true,
                        //           decoration: InputDecoration(
                        //             hintText: 'Enter your password here',
                        //             hintStyle:
                        //                 const UTextStyle().textbasefontnormal.copyWith(
                        //                       color: UColors.gray500,
                        //                     ),
                        //             border: InputBorder.none,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Row(
                          children: [
                            const SizedBox(width: USpace.space4),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '*Required. Please enter your password';
                                  }
                                  if (!RegExp(r'^[a-zA-Z0-9]+$')
                                      .hasMatch(passwordController.text)) {
                                    return 'Password must contain letters and numbers.';
                                  }

                                  return null;
                                },
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: 'Enter your password here',
                                  hintStyle: const UTextStyle()
                                      .textbasefontnormal
                                      .copyWith(
                                        color: UColors.gray500,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: USpace.space10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 420,
                  left: 14,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirmation Password',
                          style: const UTextStyle().textsmfontmedium.copyWith(
                                color: UColors.gray900,
                              ),
                        ),
                        const SizedBox(height: USpace.space10),
                        // Container(
                        //   width: 365,
                        //   height: 44,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8),
                        //     color: UColors.gray50,
                        //     border: Border.all(
                        //       color: UColors.gray300,
                        //       width: 1,
                        //     ),
                        //   ),
                        //   padding: const EdgeInsets.symmetric(horizontal: 16),
                        //   child: Row(
                        //     children: [
                        //       const Icon(Icons.lock, color: UColors.gray400),
                        //       const SizedBox(width: USpace.space10),
                        //       Expanded(
                        //         child: TextFormField(

                        //           validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return '*Required. Please enter your password';
                        //     }
                        //     if (value != passwordController.text) {
                        //       return 'Password don\'t match.';
                        //     }

                        //     return null;
                        //   },
                        //   controller: confirmpassController,

                        //           obscureText: true,
                        //           decoration: InputDecoration(
                        //             hintText: 'Confirm your password here',
                        //             hintStyle:
                        //                 const UTextStyle().textbasefontnormal.copyWith(
                        //                       color: UColors.gray500,
                        //                     ),
                        //             border: InputBorder.none,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Row(
                          children: [
                            // const Icon(Icons.lock, color: UColors.gray400),
                            const SizedBox(width: USpace.space4),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '*Required. Please enter your password';
                                  }
                                  if (value != passwordController.text) {
                                    return 'Password don\'t match.';
                                  }

                                  return null;
                                },
                                controller: confirmpassController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: 'Confirm your password here',
                                  hintStyle: const UTextStyle()
                                      .textbasefontnormal
                                      .copyWith(
                                        color: UColors.gray500,
                                      ),
                                ),
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
                  top: 510,
                  left: 16,
                  right: 16,
                  child: Container(
                    width: 380,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: validateInput,
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
                            const SizedBox(width: USpace.space4),
                            Text(
                              'Create Account',
                              style: const UTextStyle()
                                  .textbasefontmedium
                                  .copyWith(
                                    color: UColors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //     top: 570,
                //     left: 130,
                //     child: Container(
                //       decoration: const BoxDecoration(),
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 16, vertical: 16),
                //       child: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: <Widget>[
                //           Text(
                //             'Or Sign Up With',
                //             textAlign: TextAlign.left,
                //             style: const UTextStyle().textsmfontnormal.copyWith(
                //                   color: UColors.gray400,
                //                 ),
                //           ),
                //         ],
                //       ),
                //     )),
                Text(
                  'Or Sign Up With',
                  textAlign: TextAlign.left,
                  style: const UTextStyle().textsmfontnormal.copyWith(
                        color: UColors.gray400,
                      ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 120,
                      child: SignInButton(
                        Buttons.google,
                        onPressed: () {},
                        text: 'Google',
                      ),
                    ),
                    Container(
                      width: 120,
                      child: SignInButton(
                        Buttons.facebook,
                        onPressed: () {},
                        text: 'Facebook',
                      ),
                    ),
                  ],
                ),

                // Positioned(
                //   top: 600,
                //   right: 210,
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: <Widget>[
                //       Container(
                //         width: 120,
                //         padding: const EdgeInsets.symmetric(vertical: 20),
                //         child: SignInButton(
                //           Buttons.google,
                //           onPressed: () {},
                //           text: 'Google',
                //         ),
                //       ),
                //       const SizedBox(width: USpace.space8),
                //     ],
                //   ),
                // ),
                // Positioned(
                //   top: 600,
                //   right: 50,
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: <Widget>[
                //       Container(
                //         width: 120,
                //         padding: const EdgeInsets.symmetric(vertical: 20),
                //         child: SignInButton(
                //           Buttons.facebook,
                //           onPressed: () {},
                //           text: 'Facebook',
                //         ),
                //       ),
                //       const SizedBox(width: USpace.space8),
                //     ],
                //   ),
                // ),
                Positioned(
                  top: 690,
                  left: 35,
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          "Already have an account? ",
                          style: const UTextStyle().textsmfontmedium.copyWith(
                                color: UColors.gray600,
                              ),
                        ),
                        Text(
                          'Login instead',
                          style: const UTextStyle().textsmfontmedium.copyWith(
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
      ),
    );
  }
}
