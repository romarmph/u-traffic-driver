import 'package:u_traffic_driver/model/payment_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class PaymentDatabase {
  const PaymentDatabase._();

  static const PaymentDatabase _instance = PaymentDatabase._();
  static PaymentDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _collection = _firestore.collection('payments');

  Stream<PaymentDetail> getPaymentDetails(int ticketNumber) {
    return _collection
        .where('ticketNumber', isEqualTo: ticketNumber)
        .snapshots()
        .map((snapshot) {
      return PaymentDetail.fromJson(
        snapshot.docs.first.data(),
        snapshot.docs.first.id,
      );
    });
  }
}
