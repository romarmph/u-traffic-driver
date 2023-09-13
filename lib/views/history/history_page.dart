import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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
