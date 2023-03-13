import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyColors {
  MyColors._();

  static bool get isDark => Get.theme.brightness == Brightness.dark;

  static const MaterialColor primaryColor = MaterialColor(0xFFFFC491, {
    100: primary,
    200: primary,
  });

  static const Color lightGrey = Color(0xFFE8E9E9);
  static const Color primary = Color(0xFFFFC491);
  static const Color myGray = Color(0xFF545454);
  static const Color red = Color(0xFFFF594F);
  static const Color textFieldBorder = Color(0xFFE8E9E9);

  static const Color blue1 = Color(0xff10375C);
  static const Color blue2 = Color(0xff00204A);
  static const Color topAppBarBackgroundColor = Color(0xff005792);
  static const Color blueButtonColor = Color(0xff00BBF0);
  static const Color yellow = Color(0xffFDDB3A);
  static const Color black = Color(0xFF1C2026);
  static const Color scaffoldBg = Colors.white;
}