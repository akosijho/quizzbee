import 'package:flutter/services.dart';

class RemoveDoubleSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String trimmedText = newValue.text.trimRight();
    final bool hasDoubleSpace = trimmedText.endsWith('  ');

    if (hasDoubleSpace) {
      final String textWithoutPeriodAndSpace =
      trimmedText.substring(0, trimmedText.length - 1);
      return TextEditingValue(
        text: textWithoutPeriodAndSpace,
        selection: TextSelection.collapsed(offset: textWithoutPeriodAndSpace.length),
      );
    }

    return newValue;
  }
}