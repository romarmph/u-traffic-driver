import 'package:u_traffic_driver/riverpod/admin.riverpod.dart';
import 'package:u_traffic_driver/riverpod/evidence.riverpod.dart';
import 'package:u_traffic_driver/riverpod/payment_detail.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';

class TicketView extends ConsumerStatefulWidget {
  const TicketView({super.key, required this.ticket});

  final Ticket ticket;

  @override
  ConsumerState<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends ConsumerState<TicketView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Ticket'),
      ),
      body: Column(
        children: [
          TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Driver Details',
              ),
              Tab(
                text: 'Vehicle Details',
              ),
              Tab(
                text: 'Violations',
              ),
              Tab(
                text: 'Other Details',
              ),
              Tab(
                text: 'Evidences',
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    children: [
                      _detailCard(
                        widget.ticket.licenseNumber ?? "",
                        'License Number',
                      ),
                      _detailCard(
                        widget.ticket.driverName ?? "",
                        'Driver Name',
                      ),
                      _detailCard(
                        widget.ticket.birthDate != null
                            ? widget.ticket.birthDate!.toDate().toAmericanDate
                            : "",
                        'Birthdate',
                      ),
                      _detailCard(
                        widget.ticket.address ?? "",
                        'Address',
                      ),
                      _detailCard(
                        widget.ticket.phone ?? "",
                        'Contact Number',
                      ),
                      _detailCard(
                        widget.ticket.email ?? "",
                        'Email Address',
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      _detailCard(
                        widget.ticket.vehicleTypeName,
                        'Vehicle Type',
                      ),
                      _detailCard(
                        widget.ticket.plateNumber ?? "",
                        'Plate Number',
                      ),
                      _detailCard(
                        widget.ticket.engineNumber ?? "",
                        'Engine Number',
                      ),
                      _detailCard(
                        widget.ticket.chassisNumber ?? "",
                        'Chassis Number',
                      ),
                      _detailCard(
                        widget.ticket.vehicleOwner ?? "",
                        'Vehicle Owner',
                      ),
                      _detailCard(
                        widget.ticket.vehicleOwnerAddress ?? "",
                        'Vehicle Owner Address',
                      ),
                    ],
                  ),
                  ListView.builder(
                    itemCount: widget.ticket.issuedViolations.length,
                    itemBuilder: (context, index) {
                      final IssuedViolation violation =
                          widget.ticket.issuedViolations[index];

                      return ListTile(
                        title: Text(
                          violation.violation,
                        ),
                        trailing: Text(
                          violation.fine.toString(),
                          style: const TextStyle(
                            color: UColors.red400,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        titleTextStyle: const TextStyle(
                          color: UColors.gray600,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _detailCard(
                          widget.ticket.dateCreated.toDate().toAmericanDate,
                          'Date Issued',
                        ),
                        _detailCard(
                          widget.ticket.dateCreated.toDate().dueDate.formatDate,
                          'Due Date',
                        ),
                        _detailCard(
                          widget.ticket.violationDateTime
                              .toDate()
                              .toAmericanDate,
                          'Violation Date',
                        ),
                        _detailCard(
                          widget.ticket.violationDateTime.toDate().formatTime,
                          'Violation Time',
                        ),
                        _detailCard(
                          widget.ticket.violationPlace.address,
                          'Place of Violation',
                        ),
                        _detailCard(
                          formatStatus(widget.ticket.status),
                          'Ticket Status',
                        ),
                      ],
                    ),
                  ),
                  ref
                      .watch(getAllEvidencesProvider(
                    widget.ticket.ticketNumber!,
                  ))
                      .when(
                    data: (evidences) {
                      return ListView.builder(
                        itemCount: evidences.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: UColors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: UColors.gray300,
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: evidences[index].path,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    evidences[index].name,
                                    style: const TextStyle(
                                      color: UColors.gray600,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    evidences[index].description ?? "",
                                    style: const TextStyle(
                                      color: UColors.gray600,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      return const Center(
                        child: Text('Error'),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Fine',
                  style: TextStyle(
                    color: UColors.gray600,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  getTotalFine(widget.ticket.issuedViolations),
                  style: const TextStyle(
                    color: UColors.red400,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Visibility(
              visible: TicketStatus.overdue == widget.ticket.status,
              child: Container(
                decoration: const BoxDecoration(
                  color: UColors.gray100,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                      'overdue',
                      style: TextStyle(
                        color: UColors.gray600,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.ticket.ticketDueDate.toDate().dueDate.formatDate,
                      style: const TextStyle(
                        color: UColors.gray600,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: widget.ticket.status == TicketStatus.paid,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        insetPadding: const EdgeInsets.all(16),
                        child: PaymentDetailsDialog(
                          ticketNumber: widget.ticket.ticketNumber!,
                        ),
                      );
                    },
                  );
                },
                child: const Text('View Payment Details'),
              ),
            ),
            widget.ticket.cancelledBy == null
                ? const SizedBox.shrink()
                : Container(
                    decoration: const BoxDecoration(
                      color: UColors.gray100,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: ref
                        .watch(adminProvider(widget.ticket.cancelledBy!))
                        .when(data: (admin) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            'Cancelled by ${admin.firstName} ${admin.lastName}',
                            style: const TextStyle(
                              color: UColors.gray600,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.ticket.cancelledAt!.toDate().toAmericanDate,
                            style: const TextStyle(
                              color: UColors.gray600,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    }, error: (error, stackTrace) {
                      return const Center(
                        child: Text('Error'),
                      );
                    }, loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  String formatStatus(TicketStatus status) {
    return status.toString().split('.').last.split('').first.toUpperCase() +
        status.toString().split('.').last.substring(1);
  }

  String getTotalFine(List<IssuedViolation> violations) {
    double total = 0;

    for (final violation in violations) {
      total += violation.fine;
    }

    return total.toString();
  }

  Widget _detailCard(String detail, String label) {
    return Card(
      elevation: 0,
      color: UColors.gray100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DetailTile(
          detail: detail,
          label: label,
          detailStyle: const UTextStyle().textxlfontsemibold.copyWith(
                color: UColors.gray700,
              ),
          labelStyle: const UTextStyle().textsmfontmedium.copyWith(
                color: UColors.gray400,
              ),
        ),
      ),
    );
  }
}

class PaymentDetailsDialog extends ConsumerWidget {
  const PaymentDetailsDialog({
    super.key,
    required this.ticketNumber,
  });

  final int ticketNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: ref.watch(getPaymentDetailProvider(ticketNumber)).when(
        data: (paymentDetail) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Payment Details',
                  style: TextStyle(
                    color: UColors.gray600,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _detailCard(
                  paymentDetail.orNumber,
                  'OR Number',
                ),
                _detailCard(
                  paymentDetail.ticketNumber.toString(),
                  'Ticket number',
                ),
                _detailCard(
                  paymentDetail.fineAmount.toString(),
                  'Fine Amount',
                ),
                _detailCard(
                  paymentDetail.tenderedAmount.toString(),
                  'Cash Amount',
                ),
                _detailCard(
                  paymentDetail.change.toString(),
                  'Change',
                ),
                _detailCard(
                  paymentDetail.processedByName,
                  'Cashier',
                ),
                _detailCard(
                  paymentDetail.processedAt.toDate().toAmericanDate,
                  'Date Paid',
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return const Center(
            child: Text('Error'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _detailCard(String detail, String label) {
    return Card(
      elevation: 0,
      color: UColors.gray100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DetailTile(
          detail: detail,
          label: label,
          detailStyle: const UTextStyle().textxlfontsemibold.copyWith(
                color: UColors.gray700,
              ),
          labelStyle: const UTextStyle().textsmfontmedium.copyWith(
                color: UColors.gray400,
              ),
        ),
      ),
    );
  }
}
