// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';

class CartItemRegisterDto extends Equatable {
  final ProductDetailDto product;
  final String storeId;
  final int amount;
  const CartItemRegisterDto({
    required this.product,
    required this.storeId,
    required this.amount,
  });

  @override
  List<Object?> get props => [product, amount, storeId];
}
