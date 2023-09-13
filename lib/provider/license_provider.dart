import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';

class LicenseProvider extends ChangeNotifier {
  final List<LicenseDetails> _licenseList = [];

  List<LicenseDetails> get licenseList => _licenseList;

  void setLicenseList(List<LicenseDetails> licenseList) {
    _licenseList.clear();
    _licenseList.addAll(licenseList);
    notifyListeners();
  }
}
