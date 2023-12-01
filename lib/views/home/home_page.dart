import 'package:flutter/material.dart';
import 'package:u_traffic_driver/riverpod/license.riverpod.dart';
import 'package:u_traffic_driver/riverpod/ticket.riverpod.dart';
import 'package:u_traffic_driver/services/notification_service.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/navigator.dart';
import 'package:u_traffic_driver/views/home/widgets/empty_unpaid_violations.dart';
import 'package:u_traffic_driver/views/home/widgets/no_license_state_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  void getToken() async {
    await NotificationService.instance.initNotications();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ref.watch(getAllDriversLicense).when(
                  data: (data) {
                    if (data.isEmpty) {
                      return const LicenseAddButton();
                    }

                    final List<Widget> carouselItems = data
                        .map((detail) => LicenseCard(
                              licenseDetails: detail,
                            ))
                        .toList();

                    return FlutterCarousel(
                      items: carouselItems,
                      options: CarouselOptions(
                        aspectRatio: 3.2 / 2,
                      ),
                    );
                  },
                  error: (error, stackTrace) => const Center(
                    child: Text('Something went wrong'),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            const SizedBox(
              height: USpace.space14,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                'Unpaid Tickets',
                style: const UTextStyle().textsmfontmedium.copyWith(
                      color: UColors.gray500,
                    ),
              ),
            ),
            const UnpaidTicketsBuilder(),
          ],
        ),
      ),
    );
  }
}

class UnpaidTicketsBuilder extends ConsumerWidget {
  const UnpaidTicketsBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllDriversLicense).when(
          data: (data) {
            if (data.isEmpty) {
              return const Expanded(
                child: Center(
                  child: Text('Please add a license first'),
                ),
              );
            }

            return Expanded(
              child: ref.watch(getAllTickets).when(
                    data: (tickets) {
                      if (tickets.isEmpty) {
                        return const EmptyUnpaidViolationsState();
                      }

                      tickets = tickets
                          .where((element) =>
                              element.status == TicketStatus.unpaid)
                          .toList();

                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                          itemCount: tickets.length,
                          itemBuilder: (context, index) {
                            Ticket ticket = tickets[index];

                            return GestureDetector(
                              onTap: () => goTicketView(ticket),
                              child: Card(
                                elevation: 0,
                                color: UColors.red500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: DetailTile(
                                              detail: ticket.ticketNumber
                                                  .toString(),
                                              label: 'Ticket Number',
                                              labelStyle: const UTextStyle()
                                                  .textbasefontmedium
                                                  .copyWith(
                                                    color: UColors.white,
                                                  ),
                                            ),
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                        detail: ticket.licenseNumber ?? "",
                                        label: 'License Number',
                                        labelStyle: const TextStyle(
                                          color: UColors.white,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DetailTile(
                                              detail: ticket.dateCreated
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
                                              detail: ticket.dateCreated
                                                  .toDate()
                                                  .dueDate,
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
        );
  }
}
