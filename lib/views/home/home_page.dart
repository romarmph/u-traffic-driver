import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/utils/exports/services.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';
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
                'Unsettled Violation',
                style: const UTextStyle().textsmfontmedium.copyWith(
                      color: UColors.gray500,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              height: 110,
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: UColors.red500,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Traffic Violation Name',
                              style: const UTextStyle()
                                  .textlgfontmedium
                                  .copyWith(color: UColors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Date Issued',
                            style: const UTextStyle().textxsfontmedium.copyWith(
                                  color: UColors.red300,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                          child: Text(
                            'May 31, 2023',
                            style:
                                const UTextStyle().textsmfontsemibold.copyWith(
                                      color: UColors.white,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    const Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: UColors.white,
                        size: 24,
                      ),
                    ),
                    Positioned(
                        top: 60,
                        right: 8,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Tap here to view',
                            style: const UTextStyle().textxsfontmedium.copyWith(
                                  color: UColors.white,
                                ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 24),
            //       child: Text(
            //         'Recent Violations',
            //         style: const UTextStyle().textsmfontmedium.copyWith(
            //               color: UColors.gray500,
            //             ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: USpace.space176,
            //     ),
            //     TextButton(
            //         onPressed: () {},
            //         child: Text(
            //           'View All',
            //           style: const UTextStyle().textsmfontmedium.copyWith(
            //                 color: UColors.gray800,
            //               ),
            //         )),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Driving Without a Valid License',
                        style: const UTextStyle().textsmfontmedium.copyWith(
                              color: UColors.gray700,
                            )),
                    subtitle: Text(
                      'Issued by: Mar Bert Cerda',
                      style: const UTextStyle().textxsfontmedium.copyWith(
                            color: UColors.gray500,
                          ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'May 24, 2023',
                        style: const UTextStyle().textxsfontmedium.copyWith(
                              color: UColors.gray500,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: bottomNav(),
    );
  }
}
