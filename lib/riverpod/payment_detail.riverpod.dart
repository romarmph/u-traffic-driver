import 'package:u_traffic_driver/database/payment_database.dart';
import 'package:u_traffic_driver/model/payment_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

final getPaymentDetailProvider =
    StreamProvider.family<PaymentDetail, int>((ref, ticketNumber) {
  return PaymentDatabase.instance.getPaymentDetails(ticketNumber);
});
