import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';

class ViewWrapper extends StatefulWidget {
  const ViewWrapper({Key? key}) : super(key: key);

  @override
  State<ViewWrapper> createState() => ViewWrapperState();
}

class ViewWrapperState extends State<ViewWrapper> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    HistoryPage(),
    ReportPage(),
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

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          'History',
          style: const UTextStyle().textlgfontbold,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Messages',
                  style: const UTextStyle()
                      .textsmfontmedium
                      .copyWith(color: UColors.gray500),
                ),
              ),
              Card(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ListTile(
                      title: Text(
                        'Driving Without a Valid License',
                        style: const UTextStyle()
                            .textbasefontmedium
                            .copyWith(color: UColors.gray700, fontSize: 16),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Issued by: Mar Bert Cerda',
                            style: const UTextStyle()
                                .textsmfontmedium
                                .copyWith(color: UColors.gray500),
                          ),
                          Text('Date Issued: May 24, 2023',
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.star,
                              color: UColors.yellow300,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, right: 10),
                          child: Text(
                            'Php 3,000',
                            style:
                                const UTextStyle().textbasefontmedium.copyWith(
                                      color: UColors.gray700,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          'Inbox',
          style: const UTextStyle().textlgfontbold,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                'Messages',
                style: const UTextStyle()
                    .textsmfontmedium
                    .copyWith(color: UColors.gray500),
              ),
            ),
            const ListTile(
              title: Text('Report # 1002'),
              subtitle: Text('hello sir, we would like to..'),
              trailing: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('yesterday'),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )),
    );
  }
}
