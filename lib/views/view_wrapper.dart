import 'package:flutter/material.dart';
import 'package:u_traffic_driver/riverpod/complaints.riverpod.dart';
import 'package:u_traffic_driver/riverpod/driver_vehicle.riverpod.dart';
import 'package:u_traffic_driver/riverpod/ticket.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class ViewWrapper extends ConsumerStatefulWidget {
  const ViewWrapper({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewWrapper> createState() => ViewWrapperState();
}

class ViewWrapperState extends ConsumerState<ViewWrapper> {
  int currentIndex = 0;
  bool done = false;

  final List<Widget> pages = [
    const HomePage(),
    const HistoryPage(),
    const ReportPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.white,
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget bottomNav() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 1, color: UColors.gray200)),
      ),
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
            activeIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.calendar_today_rounded),
            icon: Icon(Icons.calendar_today_outlined),
            label: "History",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.inbox_rounded),
            icon: Icon(Icons.inbox_outlined),
            label: "Complaints",
          ),
        ],
      ),
    );
  }
}
