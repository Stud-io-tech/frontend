import 'dart:typed_data';

import 'package:my_fome/app/domain/dtos/payments/payment_pix_dto.dart';

abstract interface class PaymentService {
  Future<String> generateCopyPast(PaymentPixDto data);
  Future<Uint8List> generateQRCode(PaymentPixDto data);
}
