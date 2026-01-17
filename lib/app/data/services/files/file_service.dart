import 'dart:typed_data';

import 'package:my_fome/app/domain/dtos/address/address_detail_dto.dart';
import 'package:my_fome/app/domain/dtos/cartItem/cart_item_group_store_dto.dart';

abstract interface class FileService {
  Future<String> generatePDFOrder(
      CartItemGroupStoreDto data,
      AddressDetailDto addressUser,
      String code,
      String userName,
      String whatsappLink,
      {String? addressLinkMap,
      String? pixCopyPast,
      Uint8List? pixQrCode});
}
