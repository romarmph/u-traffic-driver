import 'dart:io';

import 'package:path/path.dart';
import 'package:u_traffic_driver/model/attachment_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class StorageService {
  const StorageService._();

  static const StorageService _instance = StorageService._();
  static StorageService get instance => _instance;

  static final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Attachment> uploadFile(String complaintId, Attachment file) async {
    final fileName = basename(file.url);
    final ref = _storage.ref('attachments/$complaintId').child(fileName);
    final uploadTask = ref.putFile(File(file.url));
    final snapshot = await uploadTask.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();

    return file.copyWith(url: url);
  }
}
