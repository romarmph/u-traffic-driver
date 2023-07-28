import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driverslogin/screen/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  final idController = TextEditingController();

  var obscurePassword = true;

  final _formkey = GlobalKey<FormState>();

  final collectionPath = 'driversRegisterInfo';

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

      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection(collectionPath).doc(uid).set({
        'id': 'null/test',
        'firstName': firstNameController.text,
        'middleName': middleNameController.text,
        'lastName': lastNameController.text,
        'birthDate': _birthdateController.text,
        'email': emailController.text,
        'password': passwordController.text,
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loginScreen()));
  }

  void validateInput() {
    if (_formkey.currentState!.validate()) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          text: null,
          title: 'Are you want to sure?',
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Register your account:'),
                SizedBox(height: 12.0),
                SizedBox(height: 12.0),
                TextFormField(
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
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.0),
                TextFormField(
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
                  obscureText: obscurePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;

                          if (obscurePassword == true) {
                            Icons.visibility;
                          } else
                            Icons.visibility_off;
                        });
                      },
                      icon: Icon(obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required. Please enter your password';
                    }
                    if (value != passwordController.text) {
                      return 'Password don\'t match.';
                    }

                    return null;
                  },
                  obscureText: obscurePassword,
                  controller: confirmpassController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(height: 12.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required. Please enter a First Name';
                    }
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      return 'Pleaser enter a valid First Name';
                    }
                    return null;
                  },
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(height: 12.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required. Please enter a Middle Name';
                    }
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      return 'Pleaser enter a valid Middle Name';
                    }
                    return null;
                  },
                  controller: middleNameController,
                  decoration: InputDecoration(
                    labelText: 'Middle Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(height: 12.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required. Please enter a Last Name';
                    }
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      return 'Pleaser enter a valid Last Name';
                    }
                    return null;
                  },
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(height: 12.0),
                TextField(
                  controller: _birthdateController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: 'Birthdate',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2023));
                  },
                ),
                SizedBox(height: 12.0),
                SizedBox(height: 12.0),
                // TextFormField(

                //   controller: idController,
                //   decoration: InputDecoration(
                //     labelText: 'ID',
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                ElevatedButton(
                  onPressed: validateInput,
                  style: ElevatedButton.styleFrom(),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
