import 'package:u_traffic_driver/model/complaint.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/views/report/complaint_view.dart';

class ComplaintTile extends StatelessWidget {
  const ComplaintTile({
    super.key,
    required this.complaint,
  });

  final Complaint complaint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ComplainViewPage(
              complaintId: complaint.id!,
              status: complaint.status,
              parentTitle: complaint.title,
            ),
          ),
        );
      },
      minLeadingWidth: 0,
      visualDensity: VisualDensity.comfortable,
      leading: const CircleAvatar(
          radius: 18,
          backgroundColor: UColors.gray300,
          child: Icon(
            Icons.circle_outlined,
            color: UColors.gray600,
            size: 18,
          )),
      title: Text(complaint.title),
      subtitle: Text(
        complaint.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: complaint.status == 'open'
                  ? UColors.green400
                  : UColors.blue400,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              complaint.status.capitalize,
              style: const TextStyle(
                color: UColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            complaint.createdAt.toDate().complaintAge,
            style: const UTextStyle().textsmfontmedium,
          ),
        ],
      ),
    );
  }
}
