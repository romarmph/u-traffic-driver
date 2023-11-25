
import 'package:u_traffic_driver/utils/exports/packages.dart';

class ScannerService {
  ScannerService._();

  static final ScannerService _instance = ScannerService._();

  static ScannerService get instance => _instance;

  Future<String?> detectImageFromCamera() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return null;
    }

    // Generate filepath for saving
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      //Make sure to await the call to detectEdge.
      bool success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning', // use custom localizations for android
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );

      if (success) {
        return imagePath;
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> takeImageFromCamera() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );

    if (pickedFile == null) {
      return null;
    }

    final cropped = await ImageCropper.platform.cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 10),
      compressQuality: 75,
      compressFormat: ImageCompressFormat.jpg,
      cropStyle: CropStyle.rectangle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
        )
      ],
    );

    if (cropped == null) {
      return null;
    }

    return cropped.path;
  }
}
