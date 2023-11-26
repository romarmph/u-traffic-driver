import 'package:u_traffic_driver/riverpod/complaints.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/views/report/create_complaint_page.dart';
import 'package:u_traffic_driver/views/report/widgets/complaint_tile.dart';

class ReportPage extends ConsumerWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: UColors.gray50,
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: UColors.gray50,
        foregroundColor: UColors.black,
        title: Text(
          'Inbox',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                'Complaints',
                style: const UTextStyle()
                    .textsmfontmedium
                    .copyWith(color: UColors.gray500),
              ),
            ),
            Expanded(
              child: ref.watch(getAllComplaintsProvider).when(
                    data: (complaints) {
                      if (complaints.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No complaints yet',
                              style: const UTextStyle().textlgfontbold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'You have not made any complaints yet',
                              style: const UTextStyle().textsmfontmedium,
                            ),
                          ],
                        );
                      }

                      return ListView.builder(
                        itemCount: complaints.length,
                        itemBuilder: (context, index) {
                          return ComplaintTile(
                            complaint: complaints[index],
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) => const Center(
                      child: Text('Error'),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateComplaintPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
