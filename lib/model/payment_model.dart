import 'package:u_traffic_driver/config/enums/payment_method.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class PaymentDetail {
  final String? id;
  final PaymentMethod method;
  final double fineAmount;
  final double tenderedAmount;
  final double change;
  final int ticketNumber;
  final String orNumber;
  final String ticketID;
  final String processedBy;
  final String processedByName;
  final Timestamp processedAt;

  const PaymentDetail({
    this.id,
    required this.method,
    required this.fineAmount,
    required this.tenderedAmount,
    required this.change,
    required this.ticketNumber,
    required this.orNumber,
    required this.ticketID,
    required this.processedBy,
    required this.processedAt,
    required this.processedByName,
  });

  Map<String, dynamic> toJson() {
    return {
      'method': method.toString().split('.').last,
      'fineAmount': fineAmount,
      'tenderedAmount': tenderedAmount,
      'change': change,
      'ticketNumber': ticketNumber,
      'orNumber': orNumber,
      'ticketID': ticketID,
      'processedBy': processedBy,
      'processedAt': processedAt,
      'processedByName': processedByName,
    };
  }

  factory PaymentDetail.fromJson(Map<String, dynamic> json, [String? docId]) {
    return PaymentDetail(
      id: docId,
      method: PaymentMethod.values.firstWhere(
        (element) => element.toString() == 'PaymentMethod.${json['method']}',
      ),
      fineAmount: double.parse(json['fineAmount'].toString()),
      tenderedAmount: double.parse(json['tenderedAmount'].toString()),
      change: double.parse(json['change'].toString()),
      ticketNumber: json['ticketNumber'],
      orNumber: json['orNumber'],
      ticketID: json['ticketID'],
      processedBy: json['processedBy'],
      processedByName: json['processedByName'],
      processedAt: json['processedAt'],
    );
  }

  PaymentDetail copyWith({
    String? id,
    PaymentMethod? method,
    double? fineAmount,
    double? tenderedAmount,
    double? change,
    int? ticketNumber,
    String? orNumber,
    String? ticketID,
    String? processedBy,
    String? processedByName,
    Timestamp? processedAt,
    String? editedBy,
    Timestamp? editedAt,
  }) {
    return PaymentDetail(
      id: id ?? this.id,
      method: method ?? this.method,
      fineAmount: fineAmount ?? this.fineAmount,
      tenderedAmount: tenderedAmount ?? this.tenderedAmount,
      change: change ?? this.change,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      orNumber: orNumber ?? this.orNumber,
      ticketID: ticketID ?? this.ticketID,
      processedBy: processedBy ?? this.processedBy,
      processedByName: processedByName ?? this.processedByName,
      processedAt: processedAt ?? this.processedAt,
    );
  }
}
