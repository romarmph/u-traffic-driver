import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:u_traffic_driver/services/auth_service.dart';

import '../../config/themes/colors.dart';
import '../../config/themes/spacing.dart';
import '../../config/themes/textstyles.dart';

class CompleteInfoPage extends StatefulWidget {
  const CompleteInfoPage({super.key});

  @override
  State<CompleteInfoPage> createState() => _CompleteInfoPageState();
}

class _CompleteInfoPageState extends State<CompleteInfoPage>
    with WidgetsBindingObserver {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdateController = TextEditingController();
  final idController = TextEditingController();
  final phoneController = TextEditingController();

  var obscurePassword = true;

  final _formkey = GlobalKey<FormState>();

  final collectionPath = 'drivers';

  void registerClient() async {
    final authProvider = Provider.of<AuthService>(context, listen: false);

    try {
      EasyLoading.show(
        status: 'Proccesing...',
      );

      String uid = authProvider.currentuser!.uid;
      await FirebaseFirestore.instance.collection(collectionPath).doc(uid).set({
        'firstName': firstNameController.text,
        'middleName': middleNameController.text,
        'lastName': lastNameController.text,
        'birthDate': birthdateController.text,
        'phonenumber': phoneController.text,
        'email': authProvider.currentuser!.email,
        // 'password': provider.currentDriver.password,
      });

      EasyLoading.showSuccess('User account has been registered.');
    } on FirebaseFirestore catch (e) {}
    // Navigator.push(context, MaterialPageRoute(builder: (context) => DLogin()));
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // user is about to close the app: perform logout
      AuthService().signOut();
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
                Container(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required. Please enter a First Name';
                          }
                          if (value.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return 'Pleaser enter a valid First Name';
                          }
                          return null;
                        },
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                        ),
                      ),
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Required. Please enter a Middle Name';
                          }
                          if (value.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return 'Pleaser enter a valid middle name';
                          }
                          return null;
                        },
                        controller: middleNameController,
                        decoration: const InputDecoration(
                          labelText: 'Middle Name',
                        ),
                      ),
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required. Please enter a Last Name';
                          }
                          if (value.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return 'Pleaser enter a valid Last Name';
                          }
                          return null;
                        },
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                        ),
                      ),
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        canRequestFocus: false,
                        controller: birthdateController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month),
                          labelText: 'Birthdate',
                        ),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2024));

                          if (pickeddate != null) {
                            setState(() {
                              birthdateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickeddate);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required. Please enter a Phone Number';
                          }
                          if (value.isEmpty ||
                              !RegExp(r'^(?:[+0]9)?[0-9]{11}$')
                                  .hasMatch(value)) {
                            return 'Pleaser enter a valid Phone Number';
                          }
                          return null;
                        },
                        controller: phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone No.',
                        ),
                      ),
                      const SizedBox(height: USpace.space12),
                      ElevatedButton(
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
                    ],
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
