import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String cleanedText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (cleanedText.isEmpty) {
      return const TextEditingValue(
        text: '0.00',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    String integerPart;
    String decimalPart;

    if (cleanedText.length > 2) {
      integerPart = cleanedText.substring(0, cleanedText.length - 2);
      decimalPart = cleanedText.substring(cleanedText.length - 2);
    } else {
      integerPart = '0';
      decimalPart = cleanedText.padLeft(2, '0');
    }

    integerPart = integerPart.replaceFirst(RegExp(r'^0+'), '');

    if (integerPart.isEmpty) {
      integerPart = '0';
    }

    String formattedValue = '$integerPart.$decimalPart';

    final cursorOffset = formattedValue.length;
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: cursorOffset),
    );
  }
}
