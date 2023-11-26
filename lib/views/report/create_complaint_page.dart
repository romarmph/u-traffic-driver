import 'package:flutter/services.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/database/complaints_database.dart';
import 'package:u_traffic_driver/model/attachment_model.dart';
import 'package:u_traffic_driver/model/complaint.dart';
import 'package:u_traffic_driver/services/storage_services.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/views/report/widgets/attach_ticket_card.dart';

class CreateComplaintPage extends ConsumerStatefulWidget {
  const CreateComplaintPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateComplaintPageState();
}

class _CreateComplaintPageState extends ConsumerState<CreateComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Ticket? attachedTicket;
  List<File> attachments = [];

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _submitComplaint();
  }

  void _submitComplaint() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final senderId = AuthService.instance.currentuser!.uid;

    final complaint = Complaint(
      title: title,
      description: description,
      attachedTicket: attachedTicket != null ? attachedTicket!.id! : "",
      createdAt: Timestamp.now(),
      sender: senderId,
    );

    try {
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
  Widget build(BuildContext context) {
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
          physics: const NeverScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
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
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded),
                    ),
                  ],
                ),
                attachedTicket != null
                    ? AttachTicketCard(ticket: attachedTicket!)
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
                // Row(
                //   children: [
                //     const Text('Other Attachments'),
                //     const Spacer(),
                //     IconButton(
                //       onPressed: () {},
                //       icon: const Icon(Icons.file_upload_outlined),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 8),
                // attachments.isNotEmpty
                //     ? Column(
                //         children: _buildAttachments(attachments),
                //       )
                //     : Container(
                //         padding: const EdgeInsets.all(16),
                //         decoration: BoxDecoration(
                //           color: UColors.gray100,
                //           border: Border.all(
                //             color: UColors.gray300,
                //           ),
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         child: const Text(
                //           'No attachments',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: UColors.gray400,
                //           ),
                //         ),
                //       ),
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

      return shouldPop ?? false;
    }
    return true;
  }

  List<Widget> _buildAttachments(List<File> attachments) {
    var widgets = <Widget>[];

    for (var attachment in attachments) {
      widgets.add(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: UColors.gray100,
            border: Border.all(
              color: UColors.gray300,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.attachment_rounded),
              const SizedBox(width: 8),
              Text(
                attachment.path.split('/').last,
                style: const TextStyle(
                  color: UColors.gray400,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }
}
