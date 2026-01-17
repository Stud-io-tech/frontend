import 'package:my_fome/app/domain/dtos/cartItem/cart_item_detail_dto.dart';
import 'package:my_fome/app/domain/dtos/cartItem/cart_item_group_store_dto.dart';
import 'package:my_fome/app/domain/dtos/cartItem/cart_item_register_dto.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class CartItemRepository {
  AsyncResult<CartItemDetailDto> register(CartItemRegisterDto data);
  AsyncResult<List<CartItemGroupStoreDto>> getByGroupStoreByUser(String userId);
  AsyncResult<CartItemDetailDto> updateAmount(int amount, String id);
  Future<void> delete(String id);
  Future<void> approve(String userId, String storeId);
}
