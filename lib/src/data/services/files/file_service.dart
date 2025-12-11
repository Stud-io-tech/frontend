import 'dart:typed_data';

import 'package:my_fome/src/domain/dtos/order/order_dto.dart';

abstract interface class FileService {
  Future<String> generatePDFOrder(OrderDto data,
      {Uint8List? pixQrCode, double? bring});
}
