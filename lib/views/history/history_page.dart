import 'package:u_traffic_driver/riverpod/license.riverpod.dart';
import 'package:u_traffic_driver/riverpod/ticket.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/navigator.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: UColors.gray50,
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: UColors.gray50,
        foregroundColor: UColors.black,
        title: Text(
          'Ticket History',
          style: const UTextStyle().textlgfontbold,
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.notifications_outlined,
          //     ),
          //   ),
          // )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ref.watch(getAllDriversLicense).when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('Add a license first to your tckets'),
                    );
                  }

                  return ref.watch(getAllTickets).when(
                        data: (data) {
                          if (data.isEmpty) {
                            return const Center(
                              child: Text('No tickets found'),
                            );
                          }

                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return HistoryTicketCard(
                                ticket: data[index],
                              );
                            },
                          );
                        },
                        error: (error, stackTrace) {
                          print(error);
                          print(stackTrace);
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                },
                error: (error, stackTrace) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        ),
      ),
    );
  }
}

class HistoryTicketCard extends StatelessWidget {
  const HistoryTicketCard({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      child: ListTile(
        tileColor: UColors.white,
        onTap: () {
          goTicketView(ticket);
        },
        dense: true,
        leading: CircleAvatar(
          radius: 14,
          child: Text(
            ticket.issuedViolations.length.toString(),
            style: const UTextStyle()
                .textsmfontmedium
                .copyWith(color: UColors.gray700),
          ),
        ),
        title: Text(
          'Ticket ${ticket.ticketNumber.toString()}',
          style: const UTextStyle()
              .textbasefontmedium
              .copyWith(color: UColors.gray700, fontSize: 16),
        ),
        subtitle: Text(
          'Issued: ${ticket.dateCreated.toDate().toAmericanDate}',
          overflow: TextOverflow.ellipsis,
          style: const UTextStyle()
              .textsmfontmedium
              .copyWith(color: UColors.gray500),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: ticket.status == TicketStatus.paid
                    ? UColors.green400
                    : UColors.red400,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                ticket.status == TicketStatus.paid ? 'Paid' : 'Unpaid',
                style: const TextStyle(
                  color: UColors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Text(
              '₱${getTotalFine(ticket.issuedViolations)}',
              style: const UTextStyle()
                  .textbasefontmedium
                  .copyWith(color: UColors.gray700),
            ),
          ],
        ),
      ),
    );
  }

  String getTotalFine(List<IssuedViolation> violations) {
    var totalFine = 0;

    for (var violation in violations) {
      totalFine += violation.fine;
    }

    return totalFine.toString();
  }
}
