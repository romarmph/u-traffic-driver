import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/database/license_database.dart';
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
      length: 3,
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
        actions: [
          IconButton(
            onPressed: () async {
              final result = await QuickAlert.show(
                context: context,
                type: QuickAlertType.warning,
                title: "Delete license details",
                text:
                    "Are you sure you want to delete this license details? This action cannot be undone.",
                showCancelBtn: true,
                onConfirmBtnTap: () {
                  Navigator.of(context).pop(true);
                },
              );

              if (result == null) return;

              final db = LicenseDatabase.instance;
              QuickAlert.show(
                context: navigatorKey.currentContext!,
                type: QuickAlertType.loading,
                title: "Deleting license details",
                text: "Please wait...",
              );
              await db.deleteLicenseDetails(widget.licenseDetails.licenseID!);
              Navigator.pop(navigatorKey.currentContext!);
              await QuickAlert.show(
                context: navigatorKey.currentContext!,
                type: QuickAlertType.success,
                title: "License details deleted",
                text: "License details has been deleted successfully",
              );

              Navigator.pop(navigatorKey.currentContext!);
            },
            icon: const Icon(
              Icons.delete,
              color: UColors.red500,
            ),
          ),
        ],
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
                Tab(
                  text: 'License Image',
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
                          widget.licenseDetails.birthdate!
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
                          widget.licenseDetails.expirationDate!
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
                  CachedNetworkImage(
                    imageUrl: widget.licenseDetails.photoUrl,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            color: UColors.gray700,
                          ),
                          Text(
                            "Error loading image",
                            style: const UTextStyle().textsmfontmedium.copyWith(
                                  color: UColors.gray700,
                                ),
                          ),
                        ],
                      );
                    },
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
        final authProvider = AuthService.instance;
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('License Detail QR'),
              SizedBox(
                height: 300,
                width: 300,
                child: SfBarcodeGenerator(
                  value:
                      "${widget.licenseDetails.licenseNumber}:${authProvider.currentuser!.uid}",
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
