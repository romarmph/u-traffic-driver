import 'dart:io';

import 'package:flutter/material.dart';
import 'package:u_traffic_driver/config/device/device_constraint.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class ProfilePhoto extends ConsumerWidget {
  const ProfilePhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String photoUrl = ref.watch(driverAccountProvider)!.photoUrl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: deviceWidth(context) * 0.4,
          height: deviceWidth(context) * 0.4,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: UColors.gray200,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(USpace.space4),
          child: photoUrl.isEmpty
              ? CircleAvatar(
                  radius: deviceWidth(context) * 0.2,
                  backgroundColor: UColors.gray50,
                  child: Icon(
                    Icons.person,
                    size: deviceWidth(context) * 0.5,
                    color: UColors.gray200,
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: photoUrl,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 24,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    radius: 24,
                    backgroundColor: UColors.gray50,
                    child: Icon(
                      Icons.person,
                      size: deviceWidth(context) * 0.5,
                      color: UColors.gray200,
                    ),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 24,
                    backgroundColor: UColors.white,
                    child: Icon(
                      Icons.person,
                      size: deviceWidth(context) * 0.5,
                      color: UColors.gray200,
                    ),
                  ),
                ),
        ),
        const SizedBox(height: USpace.space8),
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(USpace.space8),
                  ),
                  backgroundColor: UColors.white,
                  surfaceTintColor: UColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(USpace.space16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _changeImage(
                              ref.watch(driverAccountProvider)!.id!,
                              ImageSource.camera,
                            );
                          },
                          child: const Text('Camera'),
                        ),
                        const SizedBox(height: USpace.space8),
                        ElevatedButton(
                          onPressed: () {
                            _changeImage(
                              ref.watch(driverAccountProvider)!.id!,
                              ImageSource.gallery,
                            );
                          },
                          child: const Text('Gallery'),
                        ),
                        const SizedBox(height: USpace.space8),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Change Photo'),
        ),
      ],
    );
  }

  void _changeImage(
    String uid,
    ImageSource source,
  ) async {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front,
    );

    if (image != null) {
      try {
        QuickAlert.show(
          context: navigatorKey.currentContext!,
          type: QuickAlertType.loading,
          title: 'Uploading',
          text: 'Please wait...',
        );
        final url = await ImageService.instance.uploadImage(
          File(image.path),
          uid,
        );
        await DriverDatabase.instance.updateDriverPhotoUrl(uid, url);
        Navigator.of(navigatorKey.currentContext!).pop();
        await QuickAlert.show(
          context: navigatorKey.currentContext!,
          type: QuickAlertType.success,
          title: 'Success',
          text: 'Profile photo updated successfully.',
        );
      } catch (e) {
        QuickAlert.show(
          context: navigatorKey.currentContext!,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Something went wrong. Please try again.',
        );
      }
    }
    Navigator.of(navigatorKey.currentContext!).pop();
  }
}
