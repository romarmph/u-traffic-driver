import 'package:flutter/material.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/database/driver_vehicle_database.dart';
import 'package:u_traffic_driver/model/vehicle_model.dart';
import 'package:u_traffic_driver/riverpod/driver_vehicle.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/views/home/add_new_vehicle_view.dart';

class VehicleDetailView extends ConsumerWidget {
  const VehicleDetailView({
    super.key,
    required this.vehicle,
  });

  final DriverVehicle vehicle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(vehicleByIdStream(vehicle.id!)).when(
          data: (data) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Vehicle Details',
                  style: const UTextStyle().textlgfontbold,
                ),
                actions: [
                  IconButton(
                    onPressed: () async {
                      final result = await QuickAlert.show(
                        context: context,
                        type: QuickAlertType.confirm,
                        title: 'Delete Vehicle',
                        text: 'Are you sure you want to delete this vehicle?',
                        onConfirmBtnTap: () async {
                          Navigator.of(context).pop(true);
                        },
                      );

                      if (result != true) {
                        return;
                      }
                      Navigator.of(navigatorKey.currentContext!).pop();
                      await DriverVehicleDatabase.instance.deleteDriverVehicle(
                        vehicle.id!,
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: UColors.red500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddVehicleForm(
                            vehicle: vehicle,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: UColors.blue700,
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Brand',
                          style: const UTextStyle().textsmfontmedium,
                        ),
                        subtitle: Text(
                          vehicle.brand,
                          style: const UTextStyle().textlgfontbold,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Model',
                          style: const UTextStyle().textsmfontmedium,
                        ),
                        subtitle: Text(
                          vehicle.model,
                          style: const UTextStyle().textlgfontbold,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Plate Number',
                          style: const UTextStyle().textsmfontmedium,
                        ),
                        subtitle: Text(
                          vehicle.plateNumber!.isNotEmpty
                              ? vehicle.plateNumber!
                              : 'No Plate Number',
                          style: const UTextStyle().textlgfontbold,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Engine Number',
                          style: const UTextStyle().textsmfontmedium,
                        ),
                        subtitle: Text(
                          vehicle.engineNumber!.isNotEmpty
                              ? vehicle.engineNumber!
                              : 'No Engine Number',
                          style: const UTextStyle().textlgfontbold,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Chassis Number',
                          style: const UTextStyle().textsmfontmedium,
                        ),
                        subtitle: Text(
                          vehicle.chassisNumber!.isNotEmpty
                              ? vehicle.chassisNumber!
                              : 'No Chassis Number',
                          style: const UTextStyle().textlgfontbold,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Conduction or File Number',
                          style: const UTextStyle().textsmfontmedium,
                        ),
                        subtitle: Text(
                          vehicle.conductionOrFileNumber!.isNotEmpty
                              ? vehicle.conductionOrFileNumber!
                              : 'No Conduction or File Number',
                          style: const UTextStyle().textlgfontbold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text('Something went wrong'),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
