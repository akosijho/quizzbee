import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/my_colors.dart';

SnackbarController mySnackbar(
    {required String title, required String message, Widget? icon}) {
  return Get.snackbar(
    title,
    message,
    icon: icon,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: MyColors.blueButtonColor,
    borderRadius: 20,
    margin: const EdgeInsets.all(16),
    colorText: Colors.white,
    duration: const Duration(seconds: 4),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}