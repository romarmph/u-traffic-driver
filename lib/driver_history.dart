import 'package:flutter/material.dart';
import 'package:u_traffic_driver/config/themes/colors.dart';
import 'package:u_traffic_driver/config/themes/textstyles.dart';

class DriverHistory extends StatelessWidget {
  const DriverHistory({super.key});

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
        title: Text('History',
        style: UTextStyle().textlgfontbold,),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
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
                child: Text('All Violations',
                style: UTextStyle().textsmfontmedium.copyWith(
                  color: UColors.gray500
                ),),
              ),
              Card(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                     ListTile(
                      title: Text('Driving Without a Valid License',
                      style: const UTextStyle().textbasefontmedium.copyWith(
                        color: UColors.gray700,
                        fontSize: 16
                      ),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Issued by: Mar Bert Cerda',
                          style: UTextStyle().textsmfontmedium.copyWith(
                            color: UColors.gray500
                          ),),
                          Text('Date Issued: MAy 24, 2023',
                          style: UTextStyle().textsmfontmedium.copyWith(
                            color: UColors.gray500
                          )),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.star,
                            color: UColors.yellow300,
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.only(bottom: 10,),
                          child: Text('Php 3,000',
                          style: UTextStyle().textbasefontmedium.copyWith(
                            color: UColors.gray700,
                          ),),
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
