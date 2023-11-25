import 'package:flutter/material.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class UpdatePasswordPage extends ConsumerStatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      UpdatePasswordPageState();
}

class UpdatePasswordPageState extends ConsumerState<UpdatePasswordPage> {
  String instruction = 'Please enter your old password';
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _oldPasswordError;

  bool _isLoading = false;

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;

  @override
  void initState() {
    super.initState();
    _oldPasswordController.addListener(() {
      if (_oldPasswordController.text.isNotEmpty) {
        setState(() {
          instruction = 'Please enter your new password';
        });
      } else {
        setState(() {
          instruction = 'Please enter your old password';
        });
      }
    });
    _newPasswordController.addListener(() {
      if (_newPasswordController.text.isNotEmpty) {
        setState(() {
          instruction = 'Please confirm your new password';
        });
      } else {
        setState(() {
          instruction = 'Please enter your new password';
        });
      }
    });
    _confirmPasswordController.addListener(() {
      if (_confirmPasswordController.text.isNotEmpty) {
        setState(() {
          instruction = 'Please confirm your new password';
        });
      } else {
        setState(() {
          instruction = 'Please enter your new password';
        });
      }
    });
  }

  void _onUpdatePassword() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _updatePassword();
  }

  void _updatePassword() async {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;

    final authService = AuthService.instance;
    setState(() {
      _isLoading = true;
    });
    try {
      await authService.updatePassword(
        oldPassword,
        newPassword,
      );
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          backgroundColor: UColors.green500,
          content: Text('Password updated successfully.'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code.contains('too-many-requests')) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          const SnackBar(
            backgroundColor: UColors.red500,
            content:
                Text('Too many unsuccessful attempts. Please try again later.'),
          ),
        );
      }
      if (e.code.contains('wrong-password')) {
        setState(() {
          _oldPasswordError = 'The password provided is incorrect.';
        });
        _formKey.currentState!.validate();
      }
      if (e.code.contains('weak-password')) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('An error occured. Please try again later.'),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Security'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Update Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    instruction,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: _obscureOldPassword,
                    controller: _oldPasswordController,
                    onChanged: (value) {
                      setState(() {
                        _oldPasswordError = null;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Old Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureOldPassword = !_obscureOldPassword;
                          });
                        },
                        icon: Icon(
                          _obscureOldPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter your old password';
                      }
                      return _oldPasswordError;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: _obscureNewPassword,
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                        icon: Icon(
                          _obscureNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter your new password';
                      }

                      if (value!.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }

                      if (value.contains(' ') || value.contains('\t')) {
                        return 'Password cannot contain spaces';
                      }

                      if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]+$')
                          .hasMatch(value)) {
                        return 'Password must contain letters and numbers';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: _obscureNewPassword,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                        icon: Icon(
                          _obscureNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please confirm your new password';
                      }

                      if (value != _newPasswordController.text) {
                        return 'Password does not match with new password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: _onUpdatePassword,
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text('Update Password')),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
