import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/database/complaints_database.dart';
import 'package:u_traffic_driver/model/attachment_model.dart';
import 'package:u_traffic_driver/model/complaint.dart';
import 'package:u_traffic_driver/riverpod/license.riverpod.dart';
import 'package:u_traffic_driver/riverpod/ticket.riverpod.dart';
import 'package:u_traffic_driver/services/storage_services.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/views/report/widgets/attach_file_tile.dart';
import 'package:u_traffic_driver/views/report/widgets/attach_ticket_card.dart';

final attachedTicketProvider = StateProvider<Ticket?>((ref) => null);

class CreateComplaintPage extends ConsumerStatefulWidget {
  const CreateComplaintPage({
    super.key,
    this.parentThread,
    this.title,
  });

  final String? parentThread;
  final String? title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateComplaintPageState();
}

class _CreateComplaintPageState extends ConsumerState<CreateComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<Attachment> attachments = [];

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _submitComplaint();
  }

  void _submitComplaint() async {
    final attachedTicket = ref.read(attachedTicketProvider);
    final title = _titleController.text;
    final description = _descriptionController.text;
    final senderId = AuthService.instance.currentuser!.uid;

    Complaint complaint = Complaint(
      title: title,
      description: description,
      attachedTicket: attachedTicket != null ? attachedTicket.id! : "",
      createdAt: Timestamp.now(),
      sender: senderId,
      parentThread: widget.parentThread,
      isFromDriver: true,
    );

    if (attachedTicket != null) {
      complaint = complaint.copyWith(
        attachedTicket: attachedTicket.id!,
      );
    }

    try {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Submitting',
        text: 'Please wait while we submit your complaint.',
      );
      final docid = await ComplaintsDatabase.instance.addComplaint(complaint);

      if (attachments.isNotEmpty) {
        final List<Attachment> uploadedAttachments = await Future.wait(
          attachments
              .map((e) => StorageService.instance.uploadFile(docid, e))
              .toList(),
        );

        await ComplaintsDatabase.instance.insertAttachments(
          uploadedAttachments,
          docid,
        );
      }

      Navigator.of(navigatorKey.currentContext!).pop();

      await QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Your complaint has been submitted.',
      );

      Navigator.of(navigatorKey.currentContext!).pop();
    } catch (e) {
      await QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Error',
        text:
            'An error occured while submitting your complaint. Please try again later.',
      );

      return;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      _titleController.text = widget.title!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final attachedTicket = ref.watch(attachedTicketProvider);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Complaint',
            style: const UTextStyle().textlgfontbold,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  readOnly: widget.parentThread != null,
                  enabled: widget.parentThread == null,
                  maxLength: 50,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  minLines: 10,
                  maxLines: 10,
                  maxLength: 300,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Attach Ticket'),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding: const EdgeInsets.all(0),
                              surfaceTintColor: UColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              title: const Text('Attach Ticket'),
                              content: const TicketSelectionList(),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.add_rounded),
                    ),
                  ],
                ),
                attachedTicket != null
                    ? AttachTicketCard(ticket: attachedTicket)
                    : Container(
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
                      ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Other Attachments'),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        final pickedFiles = await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          type: FileType.custom,
                          allowedExtensions: [
                            'jpg',
                            'jpeg',
                            'png',
                            'pdf',
                            'doc',
                            'docx',
                          ],
                        );

                        if (pickedFiles == null) {
                          return;
                        }

                        for (var file in pickedFiles.files) {
                          if (file.size / 1e+6 > 25) {
                            await QuickAlert.show(
                              context: navigatorKey.currentContext!,
                              type: QuickAlertType.error,
                              title: 'Error',
                              text: 'File size must be less than 25MB',
                            );
                            return;
                          }

                          setState(() {
                            attachments.add(Attachment(
                              name: file.name,
                              url: file.path!,
                              type: file.name.split('.').last,
                              size: file.size,
                            ));
                          });
                        }
                      },
                      icon: const Icon(Icons.file_upload_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                attachments.isNotEmpty
                    ? Column(
                        children: _buildAttachments(attachments),
                      )
                    : Container(
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
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _onSubmit,
          label: const Text('Submit'),
          icon: const Icon(Icons.send_rounded),
        ),
      ),
    );
  }

  bool _didSomethingChange() {
    final attachedTicket = ref.read(attachedTicketProvider);
    return _titleController.text.isNotEmpty ||
        _descriptionController.text.isNotEmpty ||
        attachedTicket != null ||
        attachments.isNotEmpty;
  }

  Future<bool> _onWillPop() async {
    if (_didSomethingChange()) {
      final shouldPop = await QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: 'Discard changes?',
        text: 'Are you sure you want to discard your changes?',
        onConfirmBtnTap: () {
          Navigator.of(context).pop(true);
        },
        onCancelBtnTap: () {
          Navigator.of(context).pop(false);
        },
      );

      if (shouldPop) {
        ref.read(attachedTicketProvider.notifier).state = null;
      }

      return shouldPop ?? false;
    }
    return true;
  }

  List<Widget> _buildAttachments(List<Attachment> attachments) {
    var widgets = <Widget>[];

    for (var attachment in attachments) {
      widgets.add(
        AttachFileTile(
          attachment: attachment,
          onPressed: () {
            setState(() {
              this.attachments.remove(attachment);
            });
          },
        ),
      );
      widgets.add(const SizedBox(height: 8));
    }

    return widgets;
  }
}

class TicketSelectionList extends ConsumerWidget {
  const TicketSelectionList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllDriversLicense).when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Text('Add a driver\'s license first'),
          );
        }

        return ref.watch(getAllTickets).when(
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                children: data.map((ticket) {
                  return ListTile(
                    title: Text(ticket.ticketNumber!.toString()),
                    subtitle: Text(ticket.dateCreated.toDate().toAmericanDate),
                    trailing: const Icon(Icons.file_copy),
                    onTap: () {
                      ref.read(attachedTicketProvider.notifier).state = ticket;
                      Navigator.of(context).pop();
                    },
                  );
                }).toList(),
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(
                error.toString(),
              ),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            error.toString(),
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
