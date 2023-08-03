import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:u_traffic_driver/auth_service.dart';
import 'package:u_traffic_driver/dlogin.dart';
import 'package:u_traffic_driver/provider/driver_provider.dart';

import 'config/themes/colors.dart';
import 'config/themes/spacing.dart';
import 'config/themes/textstyles.dart';

class Dinfo extends StatefulWidget {
  const Dinfo({super.key});

  @override
  State<Dinfo> createState() => _DinfoState();
}

class _DinfoState extends State<Dinfo> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  final idController = TextEditingController();
  final phoneController = TextEditingController();

  var obscurePassword = true;

  final _formkey = GlobalKey<FormState>();
  
  final collectionPath = 'drivers';

  void registerClient() async {

    final provider = Provider.of<DriverProvider>(context, listen: false);
    final authProvider = Provider.of<AuthService>(context, listen: false);

    try {
      EasyLoading.show(
        status: 'Proccesing...',
      );
      // UserCredential userCredential =
      //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: provider.currentDriver.email,
      //   password: provider.currentDriver.password,
      // );

      String uid = authProvider.currentuser!.id;
      await FirebaseFirestore.instance.collection(collectionPath).doc(uid).set({
        
        'firstName': firstNameController.text,
        'middleName': middleNameController.text,
        'lastName': lastNameController.text,
        'birthDate': _birthdateController.text,
        'phonenumber': phoneController.text,
        'email': authProvider.currentuser!.email,
        // 'password': provider.currentDriver.password,
      });

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
    Navigator.push(context, MaterialPageRoute(builder: (context) => DLogin()));
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
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
                          'Personal Information',
                          style: const UTextStyle().text4xlfontmedium.copyWith(
                                color: UColors.white,
                              ),
                        ),
                        Text(
                          'Fill out this form',
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
                          'First Name',
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '*Required. Please enter a First Name';
                                  }
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value!)) {
                                    return 'Pleaser enter a valid First Name';
                                  }
                                  return null;
                                },
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  // prefixIcon: Icon(Icons.email),
                                  hintText: 'Enter your first name here',
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
                  top: 260,
                  left: 14,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: USpace.space10),
                        Text(
                          'Middle Name',
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '*Required. Please enter a Middle Name';
                                  }
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value!)) {
                                    return 'Pleaser enter a valid middle name';
                                  }
                                  return null;
                                },
                                controller: middleNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  // prefixIcon: Icon(Icons.email),
                                  hintText: 'Enter your middle name here',
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
                  top: 260,
                  left: 14,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: USpace.space10),
                        Text(
                          'Last Name',
                          style: const UTextStyle().textsmfontmedium.copyWith(
                                color: UColors.gray900,
                              ),
                        ),
                        const SizedBox(height: USpace.space10),

                        Row(
                          children: [
                            const SizedBox(width: USpace.space4),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '*Required. Please enter a Last Name';
                                  }
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value!)) {
                                    return 'Pleaser enter a valid Last Name';
                                  }
                                  return null;
                                },
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  // prefixIcon: Icon(Icons.email),
                                  hintText: 'Enter your last name here',
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
                  top: 260,
                  left: 14,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: USpace.space10),
                        Text(
                          'Birthdate',
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
                              child: TextField(
                                controller: _birthdateController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  prefixIcon: Icon(Icons.calendar_month),
                                  hintText: 'Select your birthdate',
                                  hintStyle: const UTextStyle()
                                      .textbasefontnormal
                                      .copyWith(
                                        color: UColors.gray500,
                                      ),
                                ),
                                onTap: () async {
                                  DateTime? pickeddate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2024));

                                  if (pickeddate != null) {
                                    setState(() {
                                      _birthdateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickeddate);
                                    });
                                  }
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
                        const SizedBox(height: USpace.space10),
                        Text(
                          'Phone number',
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '*Required. Please enter a Phone Number';
                                  }
                                  if (value!.isEmpty ||
                                      !RegExp(r'^(?:[+0]9)?[0-9]{11}$')
                                          .hasMatch(value!)) {
                                    return 'Pleaser enter a valid Phone Number';
                                  }
                                  return null;
                                },
                                controller: phoneController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  // prefixIcon: Icon(Icons.email),
                                  hintText: 'Enter your phone number here',
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
                  top: 510,
                  left: 16,
                  right: 16,
                  child: Container(
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
                // Positioned(
                //   top: 690,
                //   left: 35,
                //   child: TextButton(
                //     onPressed: () {},
                //     child: Row(
                //       children: [
                //         Text(
                //           "Already have an account? ",
                //           style: const UTextStyle().textsmfontmedium.copyWith(
                //                 color: UColors.gray600,
                //               ),
                //         ),
                //         Text(
                //           'Login instead',
                //           style: const UTextStyle().textsmfontmedium.copyWith(
                //                 color: UColors.blue700,
                //               ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
