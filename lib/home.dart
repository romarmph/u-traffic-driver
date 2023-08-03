import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_traffic_driver/auth_service.dart';
import 'package:u_traffic_driver/config/themes/spacing.dart';

import 'components/appdrawer.dart';
import 'config/themes/colors.dart';
import 'config/themes/textstyles.dart';

class DHome extends StatefulWidget {
  const DHome({super.key});

  @override
  State<DHome> createState() => _DHomeState();
}

class _DHomeState extends State<DHome> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    Widget bottomNav() {
      return Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: 1, color: UColors.gray200))),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: UColors.white,
          selectedItemColor: UColors.blue700,
          unselectedItemColor: UColors.gray600,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_outlined),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_copy_outlined),
              label: "Report",
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: UColors.white,
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: UColors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.notes_sharp,
            color: UColors.black,
          ),
          onPressed: () {},
        ),
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
                Icons.notifications,
                color: UColors.black,
              ),
            ),
          )
        ],
      ),
      drawer: const appDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              height: 228,
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: UColors.blue500,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/image.png',
                                  width: 97,
                                  height: 97,
                                ),
                              ),
                              const SizedBox(width: USpace.space12),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 45),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'MACARAEG',
                                      style: const UTextStyle()
                                          .textlgfontblack
                                          .copyWith(
                                            color: UColors.white,
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                    Text(
                                      'ROMAR, CABANGON',
                                      style: const UTextStyle()
                                          .textsmfontsemibold
                                          .copyWith(
                                            color: UColors.white,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: USpace.space4,
                              ),
                              Text(
                                'License Number',
                                style: const UTextStyle()
                                    .textsmfontnormal
                                    .copyWith(
                                      color: UColors.blue300,
                                    ),
                              ),
                              Text(
                                'A 14-55-012833',
                                style: const UTextStyle()
                                    .textxlfontbold
                                    .copyWith(color: UColors.white, height: 1),
                              ),
                              const SizedBox(
                                height: USpace.space8,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: USpace.space4,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expiry Date',
                                style: const UTextStyle()
                                    .textsmfontnormal
                                    .copyWith(
                                        color: UColors.blue300, height: 1),
                              ),
                              Text(
                                'Apr 10, 2024',
                                style: const UTextStyle()
                                    .textlgfontsemibold
                                    .copyWith(color: UColors.white, height: 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 35,
                      right: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/code.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 8,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Tap here',
                            style: const UTextStyle().textxsfontbold.copyWith(
                                  color: UColors.white,
                                ),
                          )),
                    ),

                  ElevatedButton(onPressed: () {
                    final provider = Provider.of<AuthService>(context, listen: false);
                    provider.signOut();
                  }, child: Text(
                    'logout'
                  ))

                  ],
                ),
              ),
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
                              style: UTextStyle()
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    'Recent Violations',
                    style: const UTextStyle().textsmfontmedium.copyWith(
                          color: UColors.gray500,
                        ),
                  ),
                ),
                const SizedBox(
                  width: USpace.space176,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: const UTextStyle().textsmfontmedium.copyWith(
                            color: UColors.gray800,
                          ),
                    )),
              ],
            ),
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
      bottomNavigationBar: bottomNav(),
    );
  }
}
