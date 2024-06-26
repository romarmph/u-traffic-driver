import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class CompleteInfoPage extends StatefulWidget {
  const CompleteInfoPage({super.key});

  @override
  State<CompleteInfoPage> createState() => _CompleteInfoPageState();
}

class _CompleteInfoPageState extends State<CompleteInfoPage>
    with WidgetsBindingObserver {
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _phoneController = TextEditingController();

  bool obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  final collectionPath = 'drivers';

  void validateInput() async {
    if (_formKey.currentState!.validate()) {
      if (!_birthdateController.text.isAgeLegal) {
        await _showDateInvalidError();
        return;
      }

      final result = await QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        text: null,
        title: 'Are you sure?',
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        onConfirmBtnTap: () async {
          Navigator.of(context).pop(true);
        },
      );

      if (result == true) {
        await _showProfileSaveSuccess();
        await saveProfile();
      }
    }
  }

  Future<void> saveProfile() async {
    final authProvider = AuthService.instance;

    final Driver driver = Driver(
      firstName: _firstNameController.text,
      middleName: _middleNameController.text,
      lastName: _lastNameController.text,
      birthDate: _birthdateController.text.toTimestamp,
      phone: _phoneController.text,
      email: authProvider.currentuser!.email!,
      isProfileComplete: true,
    );

    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(authProvider.currentuser!.uid)
        .set(driver.toJson());

    Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WidgetWrapper(),
      ),
      (route) => false,
    );
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
      AuthService.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  color: UColors.blue700,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Your Profile',
                        style: const UTextStyle().text4xlfontmedium.copyWith(
                              color: UColors.white,
                            ),
                      ),
                      Text(
                        'Please complete your profile',
                        style: const UTextStyle().textbasefontnormal.copyWith(
                              color: UColors.white,
                            ),
                      ),
                      const SizedBox(height: USpace.space16),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a First Name';
                          }
                          if (value.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return 'Pleaser enter a valid First Name';
                          }
                          return null;
                        },
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                        ),
                      ),
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        controller: _middleNameController,
                        decoration: const InputDecoration(
                          labelText: 'Middle Name',
                        ),
                      ),
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Last Name';
                          }
                          if (value.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return 'Pleaser enter a valid Last Name';
                          }
                          return null;
                        },
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                        ),
                      ),
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        canRequestFocus: false,
                        controller: _birthdateController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month),
                          labelText: 'Birthdate',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Birthdate';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2024));

                          if (pickeddate != null) {
                            String date = pickeddate.toAmericanDate;
                            setState(() {
                              _birthdateController.text = date;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        validator: (value) {
                          if (value!.isNotEmpty &&
                              !RegExp(r'^(?:[+0]9)?[0-9]{11}$')
                                  .hasMatch(value)) {
                            return 'Pleaser enter a valid Phone Number';
                          }
                          return null;
                        },
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone No.',
                        ),
                      ),
                      const SizedBox(height: USpace.space12),
                      ElevatedButton(
                        onPressed: validateInput,
                        child: Text(
                          'Complete Account',
                          style: const UTextStyle().textbasefontmedium.copyWith(
                                color: UColors.white,
                              ),
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

  Future<void> _showProfileSaveSuccess() async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Profile saved successfully',
    );
  }

  Future<void> _showDateInvalidError() async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: 'You must be 18 years old and above to register',
    );
  }

  Future<void> _showSomethingWentWrongError() async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: 'Something went wrong. Please try again later.',
    );
  }
}
