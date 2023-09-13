import 'package:u_traffic_driver/model/violation_model.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';

class ViolationProvider extends ChangeNotifier {
  List<Violation> _violationsList = [];

  List<Violation> get getViolations => _violationsList;

  void setViolations(List<Violation> violations) {
    _violationsList = violations;
    notifyListeners();
  }
}
