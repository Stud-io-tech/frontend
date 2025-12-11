// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:my_fome/src/domain/dtos/cartItem/cart_item_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/users/user_detail_dto.dart';
import 'package:my_fome/src/domain/enum/type_payment_enum.dart';

class OrderDto extends Equatable {
  final String code;
  final UserDetailDto user;
  final StoreDetailDto store;
  final String city;
  final TypePaymentEnum typePayment;
  final List<CartItemDto> cartItens;
  final double total;
  const OrderDto({
    required this.code,
    required this.user,
    required this.store,
    required this.city,
    required this.typePayment,
    required this.cartItens,
    required this.total,
  });

  @override
  List<Object?> get props =>
      [code, user, store, typePayment, cartItens, total, city];
}
