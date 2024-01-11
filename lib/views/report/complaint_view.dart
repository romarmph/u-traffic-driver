import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/model/attachment_model.dart';
import 'package:u_traffic_driver/model/complaint.dart';
import 'package:u_traffic_driver/riverpod/admin.riverpod.dart';
import 'package:u_traffic_driver/riverpod/complaints.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/views/report/create_complaint_page.dart';
import 'package:u_traffic_driver/views/report/widgets/attach_file_tile.dart';
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
            SenderTile(complaintId: complaintId),
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
                  return ReplyTile(complaint: reply);
                }

                return SenderTile(
                  complaintId: reply.id!,
                );
              },
            ).toList();
          },
          error: (error, stackTrace) => [],
          loading: () => [],
        );
  }
}

class SenderTile extends ConsumerWidget {
  const SenderTile({
    super.key,
    required this.complaintId,
  });

  final String complaintId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDriver = ref.watch(driverAccountProvider);
    return ref.watch(getComplaintByIdProvider(complaintId)).when(
        data: (complaint) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: UColors.gray50,
                      border: Border.all(
                        color: UColors.gray200,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "dwa daw ad adw  lorem ipsum dolor sit amet.",
                          style: const UTextStyle().textsmfontbold,
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          complaint.description,
                          style: const UTextStyle().textbasefontnormal,
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 4),
                        ..._buildAttachments(complaint.attachments),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    complaint.createdAt.toDate().toAmericanDateWithTime,
                    style: const UTextStyle().textxsfontmedium.copyWith(
                          color: UColors.gray400,
                        ),
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: UColors.gray300,
                borderRadius: BorderRadius.circular(40),
              ),
              child: CachedNetworkImage(
                imageUrl: currentDriver!.photoUrl,
              ),
            ),
          ],
        ),
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

class ReplyTile extends ConsumerWidget {
  const ReplyTile({
    super.key,
    required this.complaint,
  });

  final Complaint complaint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: UColors.gray300,
              borderRadius: BorderRadius.circular(40),
            ),
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
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: UColors.gray50,
                    border: Border.all(
                      color: UColors.gray200,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        complaint.title,
                        style: const UTextStyle().textsmfontbold,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        complaint.description,
                        style: const UTextStyle().textbasefontnormal,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 4),
                      ..._buildAttachments(complaint.attachments),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  complaint.createdAt.toDate().toAmericanDateWithTime,
                  style: const UTextStyle().textxsfontmedium.copyWith(
                        color: UColors.gray400,
                      ),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
        ],
      ),
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
