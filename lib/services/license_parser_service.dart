import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart' as http;
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/extensions.dart';

class LicenseParser {
  LicenseParser._();

  static final LicenseParser _instance = LicenseParser._();

  static LicenseParser get instance => _instance;

  static const _apiKey = "07ba51e882a9549227fb11534e0d04c0";

  Future<LicenseDetails?> parseLicense(String imagePath) async {
    File imageFile = File(imagePath);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    var url = Uri.parse(
        'https://api.mindee.net/v1/products/mcromar00/driver-license-parser-ph/v1/predict');

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll({
        'Authorization': 'Token $_apiKey',
      })
      ..files.add(http.MultipartFile.fromString(
        'document',
        base64Image,
      ));

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseJson = jsonDecode(
          await response.stream.bytesToString(),
        );

        final Map<String, dynamic> prediction =
            responseJson['document']['inference']['pages'][0]['prediction'];

        final Map<String, dynamic> fields = {};
        for (var list in prediction.entries) {
          List<dynamic> values = list.value['values'];

          String content = values.map((e) => e['content']).join(' ');

          fields[list.key] = content;
        }

        LicenseDetails mockup = LicenseDetails(
          licenseNumber: "",
          expirationDate: Timestamp.now(),
          driverName: "",
          address: "",
          nationality: "",
          sex: "",
          birthdate: Timestamp.now(),
          height: 0,
          weight: 0,
          agencyCode: "",
          dlcodes: "",
          conditions: "",
          bloodType: "",
          eyesColor: "",
        );

        Map<String, dynamic> mockupFields = mockup.toJson();

        mockupFields.forEach((key, value) {
          if (fields.containsKey(key.toLowerCase())) {
            if (key.toLowerCase() == 'expirationdate') {
              mockupFields[key] =
                  fields[key.toLowerCase()].toString().getTimeStamp ??
                      Timestamp.now();
            } else if (key == 'birthdate') {
              mockupFields[key] =
                  fields[key.toLowerCase()].toString().getTimeStamp ??
                      Timestamp.now();
            } else if (key == 'height') {
              mockupFields[key] =
                  double.tryParse(fields[key.toLowerCase()]) ?? 0.0;
            } else if (key == 'weight') {
              mockupFields[key] =
                  double.tryParse(fields[key.toLowerCase()]) ?? 0.0;
            } else {
              mockupFields[key] = fields[key.toLowerCase()];
            }
          }
        });

        mockupFields['firstName'] = fields['fullname'];

        return LicenseDetails.fromJson(mockupFields);
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }
}
