// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:my_fome/app/utils/constants/api_constant.dart';
import 'package:my_fome/app/data/services/client/client_service.dart';
import 'package:my_fome/app/domain/dtos/payments/payment_pix_dto.dart';

import 'payment_service.dart';

class PaymentServiceImpl implements PaymentService {
  final ClientService clientService;
  PaymentServiceImpl({
    required this.clientService,
  });
  @override
  Future<String> generateCopyPast(PaymentPixDto data) async {
    final Response response = await clientService.get(
        '${ApiConstant.basePix}?nome=${data.name}&cidade=${data.city}&chave=${data.keyPix}&valor=${data.value}&saida=br');

    return response.data['brcode'];
  }

  @override
  Future<Uint8List> generateQRCode(PaymentPixDto data) async {
    final Response response = await clientService.get(
        '${ApiConstant.basePix}?nome=${data.name}&cidade=${data.city}&chave=${data.keyPix}&valor=${data.value}&saida=qr',
        responseType: ResponseType.bytes);

    return response.data;
  }
}
