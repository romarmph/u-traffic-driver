import 'package:u_traffic_driver/config/device/device_constraint.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/utils/exports/services.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';

class AddNewLicenseView extends StatefulWidget {
  const AddNewLicenseView({super.key});

  @override
  State<AddNewLicenseView> createState() => _AddNewLicenseViewState();
}

class _AddNewLicenseViewState extends State<AddNewLicenseView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;

  final _licenseNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _dateIssuedController = TextEditingController();
  final _dateCreatedController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _sexController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _agenyCodeController = TextEditingController();
  final _licenseRestrictionController = TextEditingController();
  final _conditionsController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _eyesColorController = TextEditingController();

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
      body: Form(
        key: _formKey,
        child: Padding(
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
                // This Expanded is necessary for the TabBarView
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: USpace.space12),
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
                                child: Center(
                                  child: Text(
                                    'Take license image',
                                    style: const UTextStyle().textlgfontbold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: USpace.space12),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Takle Image'),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: PersonalDetailsForm(
                        firstNameController: _firstNameController,
                        middleNameController: _middleNameController,
                        lastNameController: _lastNameController,
                        addressController: _addressController,
                        nationalityController: _nationalityController,
                        sexController: _sexController,
                        birthDateController: _dateOfBirthController,
                        heightController: _heightController,
                        weightController: _weightController,
                      ),
                    ),
                    SingleChildScrollView(
                      child: LicenseDetailsForm(
                        licenseNumberController: _licenseNumberController,
                        expirationDateController: _expirationDateController,
                        dateIssuedController: _dateIssuedController,
                        agenyCodeController: _agenyCodeController,
                        licenseRestrictionController:
                            _licenseRestrictionController,
                        conditionsController: _conditionsController,
                        bloodTypeController: _bloodTypeController,
                        eyesColorController: _eyesColorController,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildActionButtons(),
    );
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
              onPressed: () {},
              child: const Text("Next"),
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
    required this.dateIssuedController,
    required this.agenyCodeController,
    required this.licenseRestrictionController,
    required this.conditionsController,
    required this.bloodTypeController,
    required this.eyesColorController,
  });

  final TextEditingController licenseNumberController;
  final TextEditingController expirationDateController;
  final TextEditingController dateIssuedController;
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
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: dateIssuedController,
          labelText: 'Date Issued',
          validator: (value) {
            return null;
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
    required this.firstNameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.addressController,
    required this.nationalityController,
    required this.sexController,
    required this.birthDateController,
    required this.heightController,
    required this.weightController,
  });

  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
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
          controller: firstNameController,
          labelText: 'First Name',
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: middleNameController,
          labelText: 'Middle Name',
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: lastNameController,
          labelText: 'Last Name',
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: birthDateController,
          labelText: 'Birthdate',
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: addressController,
          labelText: 'Address',
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(
          height: USpace.space12,
        ),
        LicenseFormField(
          controller: sexController,
          labelText: 'Sex',
          validator: (value) {
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
            return null;
          },
        ),
      ],
    );
  }
}