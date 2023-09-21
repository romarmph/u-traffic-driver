import 'package:u_traffic_driver/provider/driver_provider.dart';
import 'package:u_traffic_driver/services/auth_service.dart';
import 'package:u_traffic_driver/utils/exports/extensions.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';

class LicenseDetailsView extends StatefulWidget {
  const LicenseDetailsView({
    super.key,
    required this.licenseDetails,
  });

  final LicenseDetails licenseDetails;

  @override
  State<LicenseDetailsView> createState() => _LicenseDetailsViewState();
}

class _LicenseDetailsViewState extends State<LicenseDetailsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  Widget _detailCard(String detail, String label) {
    return Card(
      elevation: 0,
      color: UColors.gray100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DetailTile(
          detail: detail,
          label: label,
          detailStyle: const UTextStyle().textxlfontsemibold.copyWith(
                color: UColors.gray700,
              ),
          labelStyle: const UTextStyle().textsmfontmedium.copyWith(
                color: UColors.gray400,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View license details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(USpace.space12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Personal Information',
                ),
                Tab(
                  text: 'License Information',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: USpace.space12,
                        ),
                        _detailCard(
                          widget.licenseDetails.driverName,
                          "Driver Name",
                        ),
                        _detailCard(
                          widget.licenseDetails.birthdate
                              .toDate()
                              .toAmericanDate,
                          "Nationality",
                        ),
                        _detailCard(
                          widget.licenseDetails.nationality,
                          "Birthdate",
                        ),
                        _detailCard(
                          widget.licenseDetails.sex.getSex,
                          "Sex",
                        ),
                        _detailCard(
                          widget.licenseDetails.address,
                          "Address",
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _detailCard(
                                widget.licenseDetails.height.toString(),
                                "Height (m)",
                              ),
                            ),
                            Expanded(
                              child: _detailCard(
                                widget.licenseDetails.weight.toString(),
                                "Weight (kg)",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _detailCard(
                                widget.licenseDetails.bloodType,
                                "Bloodtype",
                              ),
                            ),
                            Expanded(
                              child: _detailCard(
                                widget.licenseDetails.eyesColor,
                                "Eyes Color",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: USpace.space12,
                        ),
                        _detailCard(
                          widget.licenseDetails.licenseNumber,
                          "License Number",
                        ),
                        _detailCard(
                          widget.licenseDetails.expirationDate
                              .toDate()
                              .toAmericanDate,
                          "Expiration Date",
                        ),
                        _detailCard(
                          widget.licenseDetails.agencyCode,
                          "Agency code",
                        ),
                        _detailCard(
                          widget.licenseDetails.dlcodes,
                          "DL Codes",
                        ),
                        _detailCard(
                          widget.licenseDetails.conditions,
                          "Conditions",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: USpace.space12,
          right: USpace.space12,
          bottom: USpace.space12,
        ),
        child: ElevatedButton.icon(
          onPressed: showQRCode,
          label: const Text('Generate QR Code'),
          icon: const Icon(Icons.qr_code),
        ),
      ),
    );
  }

  void showQRCode() {
    showDialog(
      context: context,
      builder: (context) {
        final driverProvider =
            Provider.of<DriverProvider>(context, listen: false);

        print(driverProvider.currentDriver);

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('License Detail QR'),
              SizedBox(
                height: 300,
                width: 300,
                child: SfBarcodeGenerator(
                  value: driverProvider.currentDriver.toJson().toString(),
                  symbology: QRCode(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Close"),
              ),
            ],
          ),
        );
      },
    );
  }
}
