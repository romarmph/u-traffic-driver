import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/model/attachment_model.dart';
import 'package:u_traffic_driver/model/complaint.dart';
import 'package:u_traffic_driver/riverpod/admin.riverpod.dart';
import 'package:u_traffic_driver/riverpod/complaints.riverpod.dart';
import 'package:u_traffic_driver/riverpod/ticket.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/views/report/create_complaint_page.dart';
import 'package:u_traffic_driver/views/report/widgets/attach_file_tile.dart';
import 'package:u_traffic_driver/views/report/widgets/attach_ticket_card.dart';
import 'package:path/path.dart' as path;

class ComplainViewPage extends ConsumerWidget {
  const ComplainViewPage({
    super.key,
    required this.complaintId,
    required this.status,
    required this.parentTitle,
  });

  final String complaintId;
  final String status;
  final String parentTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Complaint'),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PrimaryThreadTile(complaintId: complaintId),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Replies'),
            ),
            ..._buildReplies(ref),
          ],
        ),
      ),
      floatingActionButton: status.toLowerCase() == 'open'
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return CreateComplaintPage(
                        parentThread: complaintId,
                        title: parentTitle,
                      );
                    },
                  ),
                );
              },
              label: const Text('Reply'),
              icon: const Icon(Icons.reply),
            )
          : const SizedBox.shrink(),
    );
  }

  List<Widget> _buildReplies(WidgetRef ref) {
    return ref.watch(getAllRepliesProvider(complaintId)).when(
          data: (replies) {
            return replies.map(
              (reply) {
                final currentUser = ref.watch(driverAccountProvider);

                if (currentUser!.id != reply.sender) {
                  return AdminReplyTile(complaint: reply);
                }

                return DriverReplyTile(
                  complaint: reply,
                );
              },
            ).toList();
          },
          error: (error, stackTrace) => [],
          loading: () => [],
        );
  }
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
          complaint.attachments.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: _buildAttachments(complaint.attachments),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Container(
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
                      'No attachments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: UColors.gray400,
                      ),
                    ),
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

  List<Widget> _buildAttachments(List<Attachment> attachments) {
    var widgets = <Widget>[];

    for (var attachment in attachments) {
      widgets.add(
        AttachFileTile(
          attachment: attachment,
          onTiletap: () {
            _downloadFile(
              attachment.url,
              attachment.name,
            );
          },
        ),
      );
      widgets.add(const SizedBox(height: 8));
    }

    return widgets;
  }

  void _downloadFile(String url, String fileName) async {
    final result = await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.confirm,
      title: 'Download File',
      text: 'Are you sure to download this file?',
      onConfirmBtnTap: () {
        Navigator.of(navigatorKey.currentContext!).pop(true);
      },
    );

    if (result != true) {
      return;
    }

    QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.loading,
      title: 'Downloading',
      text: 'Please wait...',
    );

    try {
      const directory = '/storage/emulated/0/Download';
      final time = DateTime.now().millisecondsSinceEpoch;
      final fullPath = path.join(directory,
          '${fileName.split('.').first}-$time.${fileName.split('.').last}');
      await Directory(directory).create(recursive: true);

      final res = await get(Uri.parse(url));
      File(fullPath).writeAsBytes(res.bodyBytes);
      Navigator.of(navigatorKey.currentContext!).pop();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('File downloaded successfully'),
        ),
      );
    } catch (e) {
      QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Something went wrong. Please try again later.',
      );
    }
  }
}

class DriverReplyTile extends ConsumerWidget {
  const DriverReplyTile({
    super.key,
    required this.complaint,
  });

  final Complaint complaint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentDriver = ref.watch(driverAccountProvider);

    return ExpansionTileCard(
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
        complaint.attachments.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: _buildAttachments(complaint.attachments),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Container(
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
                    'No attachments',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: UColors.gray400,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  List<Widget> _buildAttachments(List<Attachment> attachments) {
    var widgets = <Widget>[];

    for (var attachment in attachments) {
      widgets.add(
        AttachFileTile(
          attachment: attachment,
          onTiletap: () {
            _downloadFile(
              attachment.url,
              attachment.name,
            );
          },
        ),
      );
      widgets.add(const SizedBox(height: 8));
    }

    return widgets;
  }

  void _downloadFile(String url, String fileName) async {
    final result = await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.confirm,
      title: 'Download File',
      text: 'Are you sure to download this file?',
      onConfirmBtnTap: () {
        Navigator.of(navigatorKey.currentContext!).pop(true);
      },
    );

    if (result != true) {
      return;
    }

    QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.loading,
      title: 'Downloading',
      text: 'Please wait...',
    );

    try {
      const directory = '/storage/emulated/0/Download';
      final time = DateTime.now().millisecondsSinceEpoch;
      final fullPath = path.join(directory,
          '${fileName.split('.').first}-$time.${fileName.split('.').last}');
      await Directory(directory).create(recursive: true);

      final res = await get(Uri.parse(url));
      File(fullPath).writeAsBytes(res.bodyBytes);
      Navigator.of(navigatorKey.currentContext!).pop();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('File downloaded successfully'),
        ),
      );
    } catch (e) {
      QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Something went wrong. Please try again later.',
      );
    }
  }
}

class AdminReplyTile extends ConsumerWidget {
  const AdminReplyTile({
    super.key,
    required this.complaint,
  });

  final Complaint complaint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionTileCard(
      elevation: 0,
      leading: ClipOval(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CircleAvatar(
          radius: 18,
          backgroundColor: UColors.gray300,
          child: ref.watch(adminProvider(complaint.sender)).when(
            data: (admin) {
              return CachedNetworkImage(
                imageUrl: admin.photoUrl,
              );
            },
            error: (error, stackTrace) {
              return const Icon(Icons.person);
            },
            loading: () {
              return const Icon(Icons.person);
            },
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
        complaint.attachments.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: _buildAttachments(complaint.attachments),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Container(
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
                    'No attachments',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: UColors.gray400,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  List<Widget> _buildAttachments(List<Attachment> attachments) {
    var widgets = <Widget>[];

    for (var attachment in attachments) {
      widgets.add(
        AttachFileTile(
          attachment: attachment,
          onTiletap: () {
            _downloadFile(
              attachment.url,
              attachment.name,
            );
          },
        ),
      );
      widgets.add(const SizedBox(height: 8));
    }

    return widgets;
  }

  void _downloadFile(String url, String fileName) async {
    final result = await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.confirm,
      title: 'Download File',
      text: 'Are you sure to download this file?',
      onConfirmBtnTap: () {
        Navigator.of(navigatorKey.currentContext!).pop(true);
      },
    );

    if (result != true) {
      return;
    }

    QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.loading,
      title: 'Downloading',
      text: 'Please wait...',
    );

    try {
      const directory = '/storage/emulated/0/Download';
      final time = DateTime.now().millisecondsSinceEpoch;
      final fullPath = path.join(directory,
          '${fileName.split('.').first}-$time.${fileName.split('.').last}');
      await Directory(directory).create(recursive: true);

      final res = await get(Uri.parse(url));
      File(fullPath).writeAsBytes(res.bodyBytes);
      Navigator.of(navigatorKey.currentContext!).pop();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('File downloaded successfully'),
        ),
      );
    } catch (e) {
      QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Something went wrong. Please try again later.',
      );
    }
  }
}
