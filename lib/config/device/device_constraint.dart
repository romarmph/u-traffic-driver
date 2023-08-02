import 'package:flutter/material.dart';

double deviceHeight(BuildContext context) {
  final double deviceHeight = MediaQuery.of(context).size.height;
  final double statusBarHeight = MediaQuery.of(context).padding.top;
  final double bottomBarHeight = MediaQuery.of(context).padding.bottom;

  return deviceHeight - statusBarHeight - bottomBarHeight;
}

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
