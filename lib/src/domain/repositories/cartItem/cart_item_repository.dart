import 'package:my_fome/src/domain/dtos/cartItem/cart_item_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_register_dto.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class CartItemRepository {
  AsyncResult<CartItemDetailDto> register(CartItemRegisterDto data);
}