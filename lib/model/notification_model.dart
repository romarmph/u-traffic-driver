import 'package:u_traffic_driver/utils/exports/exports.dart';

class UNotification {
  final String? id;
  final String title;
  final String body;
  final String? ticketId;
  final bool read;
  final String? receiverId;
  final Timestamp createdAt;

  UNotification({
    this.id,
    required this.title,
    required this.body,
    this.ticketId,
    this.read = false,
    this.receiverId,
    required this.createdAt,
  });

  factory UNotification.fromJson(Map<String, dynamic> json, String id) {
    return UNotification(
      id: id,
      title: json['title'],
      body: json['body'],
      ticketId: json['ticketId'],
      read: json['read'],
      receiverId: json['receiverId'],
      createdAt: json['createdAt'],
    );
  }
}
