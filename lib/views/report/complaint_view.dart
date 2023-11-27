import 'package:u_traffic_driver/model/complaint.dart';
import 'package:u_traffic_driver/riverpod/complaints.riverpod.dart';
import 'package:u_traffic_driver/riverpod/ticket.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/views/report/widgets/attach_ticket_card.dart';

class ComplainViewPage extends ConsumerWidget {
  const ComplainViewPage({
    super.key,
    required this.complaintId,
  });

  final String complaintId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDriver = ref.watch(driverAccountProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Complaint'),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PrimaryThreadTile(complaintId: complaintId),
            // ..._buildReplies(ref),
          ],
        ),
      ),
    );
  }

  // List<Widget> _buildReplies(WidgetRef ref) {
  //   return ref.watch(getAllRepliesProvider(complaintId)).when(
  //         data: (replies) {
  //           return replies
  //               .map(
  //                 (reply) => Padding(
  //                   padding: const EdgeInsets.only(left: 16),
  //                   child: ListTile(
  //                     leading: ClipOval(
  //                       clipBehavior: Clip.antiAliasWithSaveLayer,
  //                       child: CircleAvatar(
  //                         radius: 18,
  //                         backgroundColor: UColors.gray300,
  //                         child: CachedNetworkImage(
  //                           imageUrl: reply.senderPhotoUrl,
  //                         ),
  //                       ),
  //                     ),
  //                     title: Text(
  //                       reply.title,
  //                       style: const UTextStyle().textlgfontbold,
  //                     ),
  //                     subtitle: Text(
  //                       reply.createdAt.toDate().toAmericanDate,
  //                       style: const UTextStyle().textsmfontmedium,
  //                     ),
  //                     trailing: reply.senderId == currentDriver!.id
  //                         ? const SizedBox.shrink()
  //                         : Container(
  //                             padding: const EdgeInsets.symmetric(
  //                               horizontal: 4,
  //                               vertical: 2,
  //                             ),
  //                             decoration: BoxDecoration(
  //                               color: UColors.green400,
  //                               borderRadius: BorderRadius.circular(4),
  //                             ),
  //                             child: Text(
  //                               reply.status.capitalize,
  //                               style: const TextStyle(
  //                                 color: UColors.white,
  //                                 fontSize: 12,
  //                                 fontWeight: FontWeight.w400,
  //                               ),
  //                             ),
  //                           ),
  //                     onTap: () {
  //                       if (reply.senderId == currentDriver.id) {
  //                         return;
  //                       }

  //                       Navigator.of(context).push(
  //                         MaterialPageRoute(
  //                           builder: (_) => ComplainViewPage(
  //                             complaintId: reply.id!,
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               )
  //               .toList();
  //         },
  //         error: (error, stackTrace) => [],
  //         loading: () => [],
  //       );
  // }
}

class PrimaryThreadTile extends ConsumerWidget {
  const PrimaryThreadTile({
    super.key,
    required this.complaintId,
  });

  final String complaintId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDriver = ref.watch(driverAccountProvider);
    return ref.watch(getComplaintByIdProvider(complaintId)).when(
        data: (complaint) {
      return ExpansionTileCard(
        baseColor: UColors.white,
        expandedColor: UColors.white,
        initiallyExpanded: true,
        elevation: 0,
        leading: ClipOval(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: UColors.gray300,
            child: CachedNetworkImage(
              imageUrl: currentDriver!.photoUrl,
            ),
          ),
        ),
        title: Text(
          complaint.title,
          style: const UTextStyle().textlgfontbold,
        ),
        subtitle: Text(
          complaint.createdAt.toDate().toAmericanDate,
          style: const UTextStyle().textsmfontmedium,
        ),
        initialElevation: 0,
        shadowColor: Colors.transparent,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              complaint.description,
              style: const UTextStyle().textsmfontmedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16),
            width: double.infinity,
            child: const Text(
              'Attached Ticket',
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: complaint.attachedTicket.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: UColors.gray100,
                      border: Border.all(
                        color: UColors.gray300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'No ticket attached',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: UColors.gray400,
                      ),
                    ),
                  )
                : ref
                    .watch(getTicketByIdProvider(complaint.attachedTicket))
                    .when(
                    data: (ticket) {
                      return AttachTicketCard(
                        ticket: ticket,
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(
                          error.toString(),
                          style: const UTextStyle().textlgfontbold,
                        ),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
          ),
        ],
      );
    }, error: (error, stackTrace) {
      return Center(
        child: Text(
          error.toString(),
          style: const UTextStyle().textlgfontbold,
        ),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

class ReplyTileCard extends ConsumerWidget {
  const ReplyTileCard({
    super.key,
    required this.complaint,
  });

  final Complaint complaint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDriver = ref.watch(driverAccountProvider);
    final senderId = complaint.sender;

    return ExpansionTileCard(
      initiallyExpanded: true,
      elevation: 0,
      leading: ClipOval(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CircleAvatar(
          radius: 18,
          backgroundColor: UColors.gray300,
          child: CachedNetworkImage(
            imageUrl: currentDriver!.photoUrl,
          ),
        ),
      ),
      title: Text(
        complaint.title,
        style: const UTextStyle().textlgfontbold,
      ),
      subtitle: Text(
        complaint.createdAt.toDate().toAmericanDate,
        style: const UTextStyle().textsmfontmedium,
      ),
      initialElevation: 0,
      shadowColor: Colors.transparent,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            complaint.description,
            style: const UTextStyle().textsmfontmedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16),
          width: double.infinity,
          child: const Text(
            'Attached Ticket',
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: complaint.attachedTicket.isEmpty
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: UColors.gray100,
                    border: Border.all(
                      color: UColors.gray300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'No ticket attached',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: UColors.gray400,
                    ),
                  ),
                )
              : ref.watch(getTicketByIdProvider(complaint.attachedTicket)).when(
                  data: (ticket) {
                    return AttachTicketCard(
                      ticket: ticket,
                    );
                  },
                  error: (error, stackTrace) {
                    return Center(
                      child: Text(
                        error.toString(),
                        style: const UTextStyle().textlgfontbold,
                      ),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
