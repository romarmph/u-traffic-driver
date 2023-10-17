import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';
import 'package:u_traffic_driver/utils/exports/services.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';

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

  void validateInput() {
    if (_formKey.currentState!.validate()) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        text: null,
        title: 'Are you sure?',
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        onConfirmBtnTap: () async {
          Navigator.of(context).pop();
          QuickAlert.show(
            context: context,
            type: QuickAlertType.loading,
            text: 'Saving account...',
          );
          await saveProfile().then(
            (value) => Navigator.of(context).pop(),
          );
        },
      );
    }
  }

  Future<void> saveProfile() async {
    final authProvider = Provider.of<AuthService>(context, listen: false);

    final Driver driver = Driver(
      firstName: _firstNameController.text,
      middleName: _middleNameController.text,
      lastName: _lastNameController.text,
      birthDate: Timestamp.fromDate(DateTime.parse(_birthdateController.text)),
      phone: _phoneController.text,
      email: authProvider.currentuser!.email!,
      isProfileComplete: true,
    );

    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(authProvider.currentuser!.uid)
        .set(driver.toJson());
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
      AuthService().signOut();
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Middle Name';
                          }
                          if (value.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return 'Pleaser enter a valid middle name';
                          }
                          return null;
                        },
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
                            setState(() {
                              _birthdateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickeddate);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: USpace.space12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Phone Number';
                          }
                          if (value.isEmpty ||
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
}
