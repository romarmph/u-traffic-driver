import 'package:flutter/material.dart';
import 'package:u_traffic_driver/config/themes/colors.dart';
import 'package:u_traffic_driver/config/themes/textstyles.dart';

class DriverInbox extends StatelessWidget {
  const DriverInbox({super.key});

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
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Inbox',
        style: UTextStyle().textlgfontbold,),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
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
                  child: Text('Messages',
                  style: UTextStyle().textsmfontmedium.copyWith(
                    color: UColors.gray500
                  ),),
                ),
           const ListTile(
              title: Text('Report # 1002'),
              subtitle: Text('hello sir, we would like to..'),
              trailing: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('yesterday'),
              ),
            )
          ],
        ),
      ),
    );
  }
}