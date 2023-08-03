import 'package:flutter/material.dart';
import 'package:dashed_rect/dashed_rect.dart';
import 'package:u_traffic_driver/config/themes/colors.dart';
import 'package:u_traffic_driver/config/themes/spacing.dart';
import 'package:u_traffic_driver/config/themes/textstyles.dart';

class DriverPicture extends StatelessWidget {
  const DriverPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 700,
              height: 230,
              color: UColors.blue700,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  const SizedBox(height: USpace.space115),
                  Text(
                    'Take ID picture',
                    style: const UTextStyle().text4xlfontmedium.copyWith(
                          color: UColors.white,
                        ),
                  ),
                  Text(
                    'Please take a photo of your ',
                    style: const UTextStyle().textbasefontnormal.copyWith(
                          color: UColors.white,
                        ),
                  ),
                  const Text(
                    'Drivers License ID',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(
                  10),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      height: 250,
                      child: DashedRect(
                        color: Colors.blue,
                        strokeWidth: 2,
                        gap: 4,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/idpic.png",
                                width: 200,
                                height: 200,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 350,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          foregroundColor: UColors.gray800,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Take a Picture',
                              style: UTextStyle()
                                  .textbasefontmedium
                                  .copyWith(color: UColors.gray800),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.image_outlined,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'To complete your registration and to verify you as a licensed '
                            'driver, we require you to take a photo of your drivers license.',
                            style:
                                TextStyle(color: UColors.gray500, fontSize: 12),
                          ),
                          Row(
                            children: [
                              const Text(
                                'To learn more about this,',
                                style: TextStyle(
                                    color: UColors.gray500, fontSize: 12),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'click here. ',
                                  style: TextStyle(
                                      color: UColors.blue500, fontSize: 12),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: USpace.space96),
            // Add the button here, inside a Row
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: UColors.blue700,
                    ),
                    onPressed: () {
                      // Add your button action here
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Next'),
                        SizedBox(width: 8),
                        // Icon(
                        //   Icons.arrow_right_alt_outlined,
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
