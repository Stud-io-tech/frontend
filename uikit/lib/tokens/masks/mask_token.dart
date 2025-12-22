import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uikit/tokens/masks/currency_input_formatter.dart';

final class MaskToken {
  static final List<TextInputFormatter> phoneInput = [
    FilteringTextInputFormatter.digitsOnly,
    MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {'#': RegExp(r'[0-9]')},
    ),
  ];

  static final List<TextInputFormatter> cepInput = [
    FilteringTextInputFormatter.digitsOnly,
    MaskTextInputFormatter(
      mask: '#####-###',
      filter: {'#': RegExp(r'[0-9]')},
    ),
  ];

  static final maskFormatterPhone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  static final maskFormatterCep = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#': RegExp(r'[0-9]')},
  );

  static String formatPhoneNumber(String phoneNumber) {
    return maskFormatterPhone.maskText(phoneNumber);
  }

  static String formatCepNumber(String cepNumber) {
    return maskFormatterCep.maskText(cepNumber);
  }

  static final RegExp phoneOutput = RegExp(r'^(\d{2})(\d{5})(\d{4})$');
  static final RegExp cepOutput = RegExp(r'^(\d{5})(\d{3})$');


  static String photoOutputMacth(Match m) => '(${m[1]}) ${m[2]}-${m[3]}';

  static final RegExp removeMask = RegExp(r'\D');
  static String removeAllMask(String maskedString) {
    return maskedString.replaceAll(RegExp(r'[^\d]'), '');
  }

  static final List<TextInputFormatter> currencyInput = [
    FilteringTextInputFormatter.digitsOnly,
    CurrencyInputFormatter(),
  ];

  static final RegExp currencyOutput = RegExp(r'^(\d+)(\d{2})$');
  static String currencyOutputMatch(Match m) => '${m[1]}.${m[2]}';

  static String formatCurrency(String value) {
    final match = MaskToken.currencyOutput
        .firstMatch(value.replaceAll(MaskToken.removeMask, ''));
    if (match != null) {
      return MaskToken.currencyOutputMatch(match);
    }
    return value;
  }
}
