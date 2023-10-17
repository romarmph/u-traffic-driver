import 'package:flutter/material.dart';
import 'package:u_traffic_driver/config/enums/ticket_status.dart';
import 'package:u_traffic_driver/model/ticket_model.dart';
import 'package:u_traffic_driver/provider/license_provider.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/navigator.dart';
import 'package:u_traffic_driver/views/home/widgets/empty_unpaid_violations.dart';
import 'package:u_traffic_driver/views/home/widgets/no_license_state_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: UColors.white,
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: UColors.white,
        foregroundColor: UColors.black,
        title: Text(
          'U-Traffic',
          style: const UTextStyle().textlgfontbold.copyWith(
                color: UColors.blue700,
              ),
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
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('licenses')
                  .where('userID', isEqualTo: authProvider.currentuser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: LicenseAddButton(),
                  );
                }

                final List<Widget> carouselItems = snapshot.data!.docs
                    .map((e) => LicenseCard(
                          licenseDetails: LicenseDetails.fromJson(
                            e.data() as Map<String, dynamic>,
                          ),
                        ))
                    .toList();

                return FlutterCarousel(
                  items: carouselItems,
                  options: CarouselOptions(
                    aspectRatio: 3.2 / 2,
                  ),
                );
              },
            ),
            const SizedBox(
              height: USpace.space14,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                'Unsettled Tickets',
                style: const UTextStyle().textsmfontmedium.copyWith(
                      color: UColors.gray500,
                    ),
              ),
            ),
            const UnsettledViolationsBuilder(),
          ],
        ),
      ),
      // bottomNavigationBar: bottomNav(),
    );
  }
}

class UnsettledViolationsBuilder extends StatelessWidget {
  const UnsettledViolationsBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final licenseProvider = Provider.of<LicenseProvider>(context);

    if (licenseProvider.licenseList.isEmpty) {
      return const Expanded(
        child: EmptyUnpaidViolationsState(),
      );
    }

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tickets')
              .where('status', isEqualTo: 'unpaid')
              .where(
                'licenseNumber',
                whereIn: licenseProvider.licenseList
                    .map((e) => e.licenseNumber)
                    .toList(),
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return const EmptyUnpaidViolationsState();
            }

            final List<Ticket> tickets = snapshot.data!.docs.map((e) {
              Map<String, dynamic> map = e.data() as Map<String, dynamic>;

              map['status'] = TicketStatus.values.firstWhere(
                (element) {
                  return element.toString() == 'TicketStatus.${map["status"]}';
                },
              );

              return Ticket.fromJson(
                map,
              );
            }).toList();

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  Ticket ticket = tickets[index];

                  return GestureDetector(
                    onTap: () => goTicketView(context, ticket),
                    child: Card(
                      elevation: 0,
                      color: UColors.red500,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: DetailTile(
                                    detail: ticket.ticketNumber.toString(),
                                    label: 'Ticket Number',
                                    labelStyle: const UTextStyle()
                                        .textbasefontmedium
                                        .copyWith(
                                          color: UColors.white,
                                        ),
                                  ),
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Tap to view details',
                                      style: TextStyle(
                                        color: UColors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.info_outline,
                                      color: UColors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            DetailTile(
                              detail: ticket.licenseNumber,
                              label: 'License Number',
                              labelStyle: const TextStyle(
                                color: UColors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DetailTile(
                                    detail: ticket.dateCreated!
                                        .toDate()
                                        .toISO8601Date,
                                    label: 'Date Issued',
                                    labelStyle: const UTextStyle()
                                        .textbasefontmedium
                                        .copyWith(
                                          color: UColors.white,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: DetailTile(
                                    detail:
                                        ticket.dateCreated!.toDate().dueDate,
                                    label: 'Due Date',
                                    labelStyle: const TextStyle(
                                      color: UColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
