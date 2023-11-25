import 'package:flutter/material.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class ViewWrapper extends StatefulWidget {
  const ViewWrapper({Key? key}) : super(key: key);

  @override
  State<ViewWrapper> createState() => ViewWrapperState();
}

class ViewWrapperState extends State<ViewWrapper> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const HistoryPage(),
    const ReportPage(),
  ];

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
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_outlined),
            label: "Report",
          ),
        ],
      ),
    );
  }
}

// Create your HistoryPage, ReportPage, and HomePage widgets as before

