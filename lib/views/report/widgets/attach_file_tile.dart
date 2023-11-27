import 'package:flutter/material.dart';
import 'package:u_traffic_driver/model/attachment_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class AttachFileTile extends ConsumerWidget {
  const AttachFileTile({
    super.key,
    required this.attachment,
    this.onTiletap,
    this.onPressed,
  });

  final Attachment attachment;
  final VoidCallback? onPressed;
  final VoidCallback? onTiletap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.only(
        left: 4,
      ),
      decoration: BoxDecoration(
        color: UColors.blue400,
        border: Border.all(
          color: UColors.gray200,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: UColors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
        child: ListTile(
          onTap: onTiletap,
          contentPadding: const EdgeInsets.only(
            left: 12,
            right: 4,
          ),
          visualDensity: VisualDensity.compact,
          tileColor: UColors.gray100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(
            attachment.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            '${(attachment.size / 1e+6).toStringAsFixed(2)} MB',
          ),
          minLeadingWidth: 0,
          trailing: onPressed == null
              ? null
              : IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.remove_circle,
                    color: UColors.red500,
                  ),
                ),
        ),
      ),
    );
  }
}
