import 'package:flutter/material.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/database/driver_vehicle_database.dart';
import 'package:u_traffic_driver/model/vehicle_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class AddVehicleForm extends ConsumerStatefulWidget {
  const AddVehicleForm({
    super.key,
    this.vehicle,
  });

  final DriverVehicle? vehicle;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddVehicleFormState();
}

class _AddVehicleFormState extends ConsumerState<AddVehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _engineNumberController = TextEditingController();
  final _chassisNumberController = TextEditingController();
  final _conductionOrFileNumberController = TextEditingController();

  void _addVehicle() async {
    // if all are empty except for _brand show quick alert
    if (_plateNumberController.text.isEmpty &&
        _engineNumberController.text.isEmpty &&
        _chassisNumberController.text.isEmpty &&
        _conductionOrFileNumberController.text.isEmpty) {
      await QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Please enter at least one of the following: '
            'Plate Number, Engine Number, Chassis Number, Conduction/File Number',
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
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

      if (result != true) {
        return;
      }

      if (widget.vehicle != null) {
        final vehicle = widget.vehicle!.copyWith(
          brand: _brandController.text,
          model: _modelController.text,
          plateNumber: _plateNumberController.text,
          engineNumber: _engineNumberController.text,
          chassisNumber: _chassisNumberController.text,
          conductionOrFileNumber: _conductionOrFileNumberController.text,
        );

        QuickAlert.show(
          context: navigatorKey.currentContext!,
          type: QuickAlertType.loading,
          title: 'Saving...',
          text: 'Please wait...',
        );

        try {
          await DriverVehicleDatabase.instance.updateDriverVehicle(vehicle);
          Navigator.of(navigatorKey.currentContext!).pop();
        } catch (e) {
          Navigator.of(navigatorKey.currentContext!).pop();
          await QuickAlert.show(
            context: navigatorKey.currentContext!,
            type: QuickAlertType.error,
            title: 'Error',
            text: e.toString(),
          );
          return;
        }

        await QuickAlert.show(
          context: navigatorKey.currentContext!,
          type: QuickAlertType.success,
          title: 'Success',
          text: 'Vehicle updated successfully',
        );
        Navigator.of(navigatorKey.currentContext!).pop();
        return;
      }

      final currentUser = AuthService.instance.currentuser;
      final vehicle = DriverVehicle(
        driverId: currentUser!.uid,
        brand: _brandController.text,
        model: _modelController.text,
        plateNumber: _plateNumberController.text,
        engineNumber: _engineNumberController.text,
        chassisNumber: _chassisNumberController.text,
        conductionOrFileNumber: _conductionOrFileNumberController.text,
      );
      QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.loading,
        title: 'Saving...',
        text: 'Please wait...',
      );
      try {
        await DriverVehicleDatabase.instance.addDriverVehicle(vehicle);
        Navigator.of(navigatorKey.currentContext!).pop();
      } catch (e) {
        Navigator.of(navigatorKey.currentContext!).pop();
        await QuickAlert.show(
          context: navigatorKey.currentContext!,
          type: QuickAlertType.error,
          title: 'Error',
          text: e.toString(),
        );
        return;
      }

      await QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Vehicle added successfully',
      );

      Navigator.of(navigatorKey.currentContext!).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.vehicle != null) {
      _brandController.text = widget.vehicle!.brand;
      _modelController.text = widget.vehicle!.model;
      _plateNumberController.text = widget.vehicle!.plateNumber!;
      _engineNumberController.text = widget.vehicle!.engineNumber!;
      _chassisNumberController.text = widget.vehicle!.chassisNumber!;
      _conductionOrFileNumberController.text =
          widget.vehicle!.conductionOrFileNumber!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(USpace.space12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: USpace.space12,
              ),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(
                  labelText: 'Brand',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter brand';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: USpace.space12,
              ),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(
                  labelText: 'Mode',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter model';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: USpace.space12,
              ),
              TextFormField(
                controller: _plateNumberController,
                decoration: const InputDecoration(
                  labelText: 'Plate Number',
                ),
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(
                height: USpace.space12,
              ),
              TextFormField(
                controller: _engineNumberController,
                decoration: const InputDecoration(
                  labelText: 'Engine Number',
                ),
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(
                height: USpace.space12,
              ),
              TextFormField(
                controller: _chassisNumberController,
                decoration: const InputDecoration(
                  labelText: 'Chassis Number',
                ),
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(
                height: USpace.space12,
              ),
              TextFormField(
                controller: _conductionOrFileNumberController,
                decoration: const InputDecoration(
                  labelText: 'Conduction/File Number',
                ),
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(
                height: USpace.space12,
              ),
              ElevatedButton(
                onPressed: _addVehicle,
                child: const Text('Add Vehicle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
