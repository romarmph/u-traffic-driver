import 'package:u_traffic_driver/config/device/device_constraint.dart';
import 'package:u_traffic_driver/config/enums/ticket_status.dart';
import 'package:u_traffic_driver/model/ticket_model.dart';
import 'package:u_traffic_driver/model/violation_model.dart';
import 'package:u_traffic_driver/provider/violations_provider.dart';
import 'package:u_traffic_driver/utils/exports/extensions.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/utils/exports/services.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';

class TicketView extends StatefulWidget {
  const TicketView({super.key, required this.ticket});

  final Ticket ticket;

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final violationProvider = Provider.of<ViolationProvider>(context);

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
                text: 'Other Detials',
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
                        widget.ticket.licenseNumber,
                        'License Number',
                      ),
                      _detailCard(
                        widget.ticket.firstName,
                        'First Name',
                      ),
                      _detailCard(
                        widget.ticket.middleName,
                        'Middle Name',
                      ),
                      _detailCard(
                        widget.ticket.lastName,
                        'Last Name',
                      ),
                      _detailCard(
                        widget.ticket.birthDate.toDate().toAmericanDate,
                        'Last Name',
                      ),
                      _detailCard(
                        widget.ticket.address,
                        'Address',
                      ),
                      _detailCard(
                        widget.ticket.phone,
                        'Contact Number',
                      ),
                      _detailCard(
                        widget.ticket.email,
                        'Email Address',
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      _detailCard(
                        widget.ticket.vehicleType,
                        'Vehicle Type',
                      ),
                      _detailCard(
                        widget.ticket.plateNumber,
                        'Plate Number',
                      ),
                      _detailCard(
                        widget.ticket.engineNumber,
                        'Engine Number',
                      ),
                      _detailCard(
                        widget.ticket.chassisNumber,
                        'Chassis Number',
                      ),
                      _detailCard(
                        widget.ticket.vehicleOwner,
                        'Vehicle Owner',
                      ),
                      _detailCard(
                        widget.ticket.vehicleOwnerAddress,
                        'Vehicle Owner Address',
                      ),
                    ],
                  ),
                  Consumer<ViolationProvider>(
                    builder: (context, value, child) {
                      final List<Violation> selected = [];

                      for (final violation in value.getViolations) {
                        if (widget.ticket.violationsID.contains(violation.id)) {
                          selected.add(violation);
                        }
                      }

                      return ListView.builder(
                        itemCount: selected.length,
                        itemBuilder: (context, index) {
                          final Violation violation = selected[index];

                          return ListTile(
                            title: Text(
                              violation.name,
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
                      );
                    },
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _detailCard(
                          widget.ticket.dateCreated!.toDate().toAmericanDate,
                          'Date Issued',
                        ),
                        _detailCard(
                          widget.ticket.dateCreated!
                              .toDate()
                              .dueDate
                              .formatDate,
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
                          widget.ticket.placeOfViolation['address'],
                          'Place of Violation',
                        ),
                        _detailCard(
                          formatStatus(widget.ticket.status),
                          'Ticket Status',
                        ),
                      ],
                    ),
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
                  'Total Amount Due',
                  style: TextStyle(
                    color: UColors.gray600,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  getTotalFine(violationProvider.getViolations
                      .where(
                        (element) => widget.ticket.violationsID.contains(
                          element.id,
                        ),
                      )
                      .toList()),
                  style: const TextStyle(
                    color: UColors.red400,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Pay Ticket'),
            ),
          ],
        ),
      ),
    );
  }

  String formatStatus(TicketStatus status) {
    return status.toString().split('.').last.split('').first.toUpperCase() +
        status.toString().split('.').last.substring(1);
  }

  String getTotalFine(List<Violation> violations) {
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
