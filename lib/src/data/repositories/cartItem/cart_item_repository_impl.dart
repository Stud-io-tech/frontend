import 'package:dio/dio.dart';
import 'package:my_fome/src/constants/api_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/exceptions/rest_exception.dart';
import 'package:my_fome/src/data/services/client/client_service.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_detail_dto.dart';

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
}
