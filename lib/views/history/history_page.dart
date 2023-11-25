import 'package:u_traffic_driver/riverpod/ticket.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/views/home/ticket_view.dart';

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
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Ticket History',
          style: const UTextStyle().textlgfontbold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ref.watch(getAllTickets).when(
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
                error: (error, stackTrace) => const Center(
                  child: Text('Something went wrong'),
                ),
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
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ListTile(
            title: Text(
              ticket.ticketNumber.toString(),
              style: const UTextStyle()
                  .textbasefontmedium
                  .copyWith(color: UColors.gray700, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Issued by: ${ticket.enforcerName}',
                  style: const UTextStyle()
                      .textsmfontmedium
                      .copyWith(color: UColors.gray500),
                ),
                Text(
                    'Date Issued: ${ticket.dateCreated.toDate().toAmericanDate}',
                    style: const UTextStyle()
                        .textsmfontmedium
                        .copyWith(color: UColors.gray500)),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return TicketView(
                          ticket: ticket,
                        );
                      }),
                    );
                  },
                  icon: const Icon(
                    Icons.star,
                    color: UColors.yellow300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: Text(
                  getTotalFine(ticket.issuedViolations),
                  style: const UTextStyle().textbasefontmedium.copyWith(
                        color: UColors.gray700,
                      ),
                ),
              ),
            ],
          ),
        ],
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
