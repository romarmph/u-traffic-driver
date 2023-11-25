import 'dart:io';

import 'package:path/path.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class ImageService {
  const ImageService._();

  static const ImageService _instance = ImageService._();
  static ImageService get instance => _instance;

  static final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile, String uid) async {
    final String type = basename(imageFile.path).split('.').last;
    final String fileName = '$uid.$type';
    final Reference ref = _storage.ref('profileImage/').child(fileName);
    final UploadTask uploadTask = ref.putFile(imageFile);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  Future<String?> uploadLicense(File imageFile, String licenseNumber) async {
    final String type = basename(imageFile.path).split('.').last;
    final String dateCreated = DateTime.now().millisecondsSinceEpoch.toString();
    final String fileName = '$licenseNumber-$dateCreated.$type';
    final Reference ref = _storage.ref('license-images/').child(fileName);
    final UploadTask uploadTask = ref.putFile(imageFile);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
