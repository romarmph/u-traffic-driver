import 'package:flutter/services.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/database/license_database.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/utils/exports/services.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';
import 'package:u_traffic_driver/utils/exports/extensions.dart';

class AddNewLicenseView extends StatefulWidget {
  const AddNewLicenseView({super.key});

  @override
  State<AddNewLicenseView> createState() => _AddNewLicenseViewState();
}

class _AddNewLicenseViewState extends State<AddNewLicenseView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;
  String? imagePath;

  final _licenseNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _driverNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _sexController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _agencyCodeController = TextEditingController();
  final _dlcodesController = TextEditingController();
  final _conditionsController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _eyesColorController = TextEditingController();

  String? previousImage;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New License'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(USpace.space12),
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: const [
                Tab(text: 'Image'),
                Tab(text: 'Personal Details'),
                Tab(text: 'License Details'),
              ],
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: USpace.space16),
                          DashedRect(
                            color: UColors.gray300,
                            gap: 12,
                            strokeWidth: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  USpace.space8,
                                ),
                                color: UColors.gray100,
                              ),
                              child: AspectRatio(
                                aspectRatio: 3 / 2,
                                child: imagePath != null
                                    ? Image.file(File(imagePath!))
                                    : Center(
                                        child: Text(
                                          'Take license image',
                                          style: const UTextStyle()
                                              .textlgfontsemibold
                                              .copyWith(
                                                color: UColors.gray500,
                                              ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: USpace.space16),
                          ElevatedButton(
                            onPressed: () async {
                              final path = await takeImage();

                              if (path != null) {
                                previousImage = path;
                              }

                              if (path == null && previousImage != null) {
                                setState(() {
                                  imagePath = previousImage;
                                });
                                return;
                              }

                              setState(() {
                                imagePath = path;
                              });
                            },
                            child: const Text('Take Image'),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: PersonalDetailsForm(
                        driverNameController: _driverNameController,
                        addressController: _addressController,
                        nationalityController: _nationalityController,
                        sexController: _sexController,
                        birthDateController: _birthdateController,
                        heightController: _heightController,
                        weightController: _weightController,
                      ),
                    ),
                    SingleChildScrollView(
                      child: LicenseDetailsForm(
                        licenseNumberController: _licenseNumberController,
                        expirationDateController: _expirationDateController,
                        agenyCodeController: _agencyCodeController,
                        licenseRestrictionController: _dlcodesController,
                        conditionsController: _conditionsController,
                        bloodTypeController: _bloodTypeController,
                        eyesColorController: _eyesColorController,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(),
    );
  }

  void showError([String title = "Error", String text = ""]) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: title,
      text: text,
    );
  }

  void showLoading() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      text: "Loading...",
    );
  }

  void popLoading() {
    Navigator.pop(context);
  }

  Future<String?> takeImage() async {
    final path = await ScannerService.instance.takeImageFromCamera();
    if (path == null) {
      return null;
    }
    showLoading();
    final LicenseDetails? details =
        await LicenseParser.instance.parseLicense(path);
    popLoading();

    if (details == null) {
      showError("Error", "No license details found");
      return null;
    }

    _licenseNumberController.text = details.licenseNumber;
    _expirationDateController.text = details.expirationDate != null
        ? details.expirationDate!.toDate().toAmericanDate
        : "";
    _driverNameController.text = details.driverName;
    _addressController.text = details.address;
    _birthdateController.text = details.birthdate != null
        ? details.birthdate!.toDate().toAmericanDate
        : "";
    _nationalityController.text = details.nationality;
    _sexController.text =
        details.sex.toLowerCase() != "f" || details.sex.toLowerCase() != "m"
            ? ""
            : details.sex;
    _heightController.text = details.height.toString();
    _weightController.text = details.weight.toString();
    _agencyCodeController.text = details.agencyCode;
    _dlcodesController.text = details.dlcodes;
    _conditionsController.text = details.conditions;
    _bloodTypeController.text = details.bloodType;
    _eyesColorController.text = details.eyesColor;

    return path;
  }

  Future<void> saveLicense() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    LicenseDetails licenseDetails = LicenseDetails(
      licenseNumber: _licenseNumberController.text,
      expirationDate:
          _expirationDateController.text.tryParseToDateTime!.toTimestamp,
      driverName: _driverNameController.text,
      address: _addressController.text,
      nationality: _nationalityController.text,
      sex: _sexController.text,
      birthdate: _birthdateController.text.tryParseToDateTime!.toTimestamp,
      height: double.parse(_heightController.text),
      weight: double.parse(_weightController.text),
      agencyCode: _agencyCodeController.text,
      dlcodes: _dlcodesController.text,
      conditions: _conditionsController.text,
      bloodType: _bloodTypeController.text,
      eyesColor: _eyesColorController.text,
      userID: AuthService.instance.currentuser!.uid,
      dateCreated: Timestamp.now(),
    );

    showLoading();
    try {
      final path = await ImageService.instance.uploadLicense(
        File(imagePath!),
        licenseDetails.licenseNumber,
      );
      licenseDetails = licenseDetails.copyWith(
        photoUrl: path,
      );
      await LicenseDatabase.instance.addLicenseDetails(
        licenseDetails,
      );
      popLoading();
    } catch (e) {
      popLoading();
      showError("Error", e.toString());
    }

    await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.success,
      title: "Success",
      text: "License added successfully",
    );

    Navigator.pop(navigatorKey.currentContext!);
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(USpace.space12),
      decoration: const BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(USpace.space24),
          topRight: Radius.circular(USpace.space24),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
            color: UColors.gray200,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ),
          const SizedBox(width: USpace.space16),
          Expanded(
            child: ElevatedButton(
              onPressed: () async => await saveLicense(),
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LicenseDetailsForm extends StatelessWidget {
  const LicenseDetailsForm({
    super.key,
    required this.licenseNumberController,
    required this.expirationDateController,
    required this.agenyCodeController,
    required this.licenseRestrictionController,
    required this.conditionsController,
    required this.bloodTypeController,
    required this.eyesColorController,
  });

  final TextEditingController licenseNumberController;
  final TextEditingController expirationDateController;
  final TextEditingController agenyCodeController;
  final TextEditingController licenseRestrictionController;
  final TextEditingController conditionsController;
  final TextEditingController bloodTypeController;
  final TextEditingController eyesColorController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: licenseNumberController,
          labelText: 'License Number',
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: expirationDateController,
          labelText: 'Expiration Date',
          readOnly: true,
          validator: (value) {
            return null;
          },
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            if (date != null) {
              expirationDateController.text = date.toAmericanDate;
            }
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: agenyCodeController,
          labelText: 'Agency Code',
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: licenseRestrictionController,
          labelText: 'License Restriction',
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: conditionsController,
          labelText: 'Conditions',
          validator: (value) {
            return null;
          },
        ),
      ],
    );
  }
}

class PersonalDetailsForm extends StatelessWidget {
  const PersonalDetailsForm({
    super.key,
    required this.driverNameController,
    required this.addressController,
    required this.nationalityController,
    required this.sexController,
    required this.birthDateController,
    required this.heightController,
    required this.weightController,
  });

  final TextEditingController driverNameController;
  final TextEditingController addressController;
  final TextEditingController nationalityController;
  final TextEditingController sexController;
  final TextEditingController birthDateController;
  final TextEditingController heightController;
  final TextEditingController weightController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: driverNameController,
          labelText: 'Driver Name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Driver name is required";
            }

            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: birthDateController,
          labelText: 'Birthdate',
          readOnly: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Birthdate is required";
            }

            return null;
          },
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (date != null) {
              birthDateController.text = date.toAmericanDate;
            }
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: addressController,
          labelText: 'Address',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Address is required";
            }

            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: sexController,
          labelText: 'Sex',
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[FfMm]")),
            TextInputFormatter.withFunction((oldValue, newValue) {
              return newValue.copyWith(
                text: newValue.text.toUpperCase(),
              );
            }),
            LengthLimitingTextInputFormatter(1),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Sex is required';
            }

            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: nationalityController,
          labelText: 'Nationality',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Nationality is required';
            }

            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: heightController,
          labelText: 'Height',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Height is requried';
            }

            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: weightController,
          labelText: 'Weight',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Weight is requried';
            }
            return null;
          },
        ),
      ],
    );
  }
}
