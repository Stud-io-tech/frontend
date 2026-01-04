import 'package:dio/dio.dart';
import 'package:my_fome/src/constants/api_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/exceptions/rest_exception.dart';
import 'package:my_fome/src/data/services/client/client_service.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_group_store_dto.dart';

import 'package:my_fome/src/domain/dtos/cartItem/cart_item_register_dto.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/repositories/cartItem/cart_item_repository.dart';

class CartItemRepositoryImpl implements CartItemRepository {
  final ClientService clientService;
  CartItemRepositoryImpl({
    required this.clientService,
  });

  @override
  AsyncResult<CartItemDetailDto> register(CartItemRegisterDto data) async {
    try {
      final Response response = await clientService.post(
        ApiConstant.cartItem,
        data.toMap(),
        requiresAuth: true,
      );
      final CartItemDetailDto cartItemRegister =
          CartItemDetailDto.fromMap(response.data['cartItems']);
      return Success(cartItemRegister);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorCreatingAddressMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<List<CartItemGroupStoreDto>> getByGroupStoreByUser(
      String userId) async {
    try {
      final Response response = await clientService.get(
        "${ApiConstant.cartItem}/stores/$userId",
        requiresAuth: true,
      );
      final List<dynamic> resultList = response.data;
      final List<CartItemGroupStoreDto> resultCartItems = resultList
          .map((item) => CartItemGroupStoreDto.fromMap(item as Map<String, dynamic>))
          .toList();
      return Success(resultCartItems);
    } on DioException catch (e) {
      return Failure(
        RestException(
            message: TextConstant.errorListStoresMessage,
            statusCode: e.response?.statusCode ?? 500),
      );
    }
  }
}
