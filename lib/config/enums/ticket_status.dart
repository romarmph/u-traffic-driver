import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';

enum TicketStatus {
  paid,
  unpaid,
  cancelled,
  refunded,
  expired,
}

extension TicketStatusExtension on TicketStatus {
  Color get color {
    switch (this) {
      case TicketStatus.paid:
        return UColors.green500;
      case TicketStatus.unpaid:
        return UColors.red500;
      case TicketStatus.cancelled:
        return UColors.gray500;
      case TicketStatus.refunded:
        return UColors.orange500;
      case TicketStatus.expired:
        return UColors.purple500;
      default:
        return UColors.gray500;
    }
  }

  String get name {
    switch (this) {
      case TicketStatus.paid:
        return 'Paid';
      case TicketStatus.unpaid:
        return 'Unpaid';
      case TicketStatus.cancelled:
        return 'Cancelled';
      case TicketStatus.refunded:
        return 'Refunded';
      case TicketStatus.expired:
        return 'Expired';
      default:
        return 'Unknown';
    }
  }
}
