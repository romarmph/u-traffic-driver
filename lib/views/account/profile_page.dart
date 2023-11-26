import 'package:flutter/material.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({
    super.key,
    required this.currentDriver,
  });

  final Driver currentDriver;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthdateController = TextEditingController();
  Timestamp? _newBirthdate;

  bool _didSometincChange = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.currentDriver.firstName;
    _middleNameController.text = widget.currentDriver.middleName;
    _lastNameController.text = widget.currentDriver.lastName;
    _emailController.text = widget.currentDriver.email;
    _phoneController.text = widget.currentDriver.phone;
    _birthdateController.text =
        widget.currentDriver.birthDate.toDate().toAmericanDate;
    _firstNameController.addListener(() {
      setState(() {
        _didSometincChange =
            _firstNameController.text != widget.currentDriver.firstName;
      });
    });

    _middleNameController.addListener(() {
      setState(() {
        _didSometincChange =
            _middleNameController.text != widget.currentDriver.middleName;
      });
    });

    _lastNameController.addListener(() {
      setState(() {
        _didSometincChange =
            _lastNameController.text != widget.currentDriver.lastName;
      });
    });

    _phoneController.addListener(() {
      setState(() {
        _didSometincChange =
            _phoneController.text != widget.currentDriver.phone;
      });
    });

    _birthdateController.addListener(() {
      setState(() {
        _didSometincChange = _birthdateController.text !=
            widget.currentDriver.birthDate.toDate().toAmericanDate;
      });
    });
  }

  void _saveChanges() async {
    final db = DriverDatabase.instance;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final driver = widget.currentDriver.copyWith(
      firstName: _firstNameController.text,
      middleName: _middleNameController.text,
      lastName: _lastNameController.text,
      phone: _phoneController.text,
      birthDate: _newBirthdate ?? widget.currentDriver.birthDate,
    );

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Saving changes',
    );

    await db.updateDriver(driver, widget.currentDriver.id!);
    Navigator.of(navigatorKey.currentContext!).pop();

    await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.success,
      title: 'Changes saved',
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthdateController.dispose();
    _didSometincChange = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_newBirthdate != null) {
      _birthdateController.text = _newBirthdate!.toDate().toAmericanDate;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Visibility(
            visible: _didSometincChange,
            child: TextButton(
              onPressed: () {
                _firstNameController.text = widget.currentDriver.firstName;
                _middleNameController.text = widget.currentDriver.middleName;
                _lastNameController.text = widget.currentDriver.lastName;
                _phoneController.text = widget.currentDriver.phone;
                _birthdateController.text =
                    widget.currentDriver.birthDate.toDate().toAmericanDate;
                _newBirthdate = null;
                setState(() {
                  _didSometincChange = false;
                });
              },
              child: const Text('Cancel'),
            ),
          ),
          const SizedBox(width: USpace.space8),
          Visibility(
            visible: _didSometincChange,
            child: FilledButton(
              onPressed: _saveChanges,
              child: const Text('Save'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(USpace.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProfilePhoto(),
            const SizedBox(height: USpace.space12),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('First Name'),
                  const SizedBox(height: USpace.space4),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: USpace.space12),
                  const Text('Middle Name'),
                  const SizedBox(height: USpace.space4),
                  TextFormField(
                    controller: _middleNameController,
                    decoration: const InputDecoration(
                      hintText: 'Middle Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your middle name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: USpace.space12),
                  const Text('Last Name'),
                  const SizedBox(height: USpace.space4),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: USpace.space12),
                  const Text('Birthdate'),
                  const SizedBox(height: USpace.space4),
                  TextFormField(
                    readOnly: true,
                    controller: _birthdateController,
                    decoration: const InputDecoration(
                      hintText: 'Birthdate',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: widget.currentDriver.birthDate.toDate(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (date != null) {
                        setState(() {
                          _newBirthdate = Timestamp.fromDate(date);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your birthday';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: USpace.space12),
                  const Text('Email'),
                  const SizedBox(height: USpace.space4),
                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: USpace.space12),
                  const Text('Phone'),
                  const SizedBox(height: USpace.space4),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Phone',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
