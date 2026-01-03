// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';
import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';

import 'package:my_fome/src/data/services/messages/result_message_service.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_register_dto.dart';
import 'package:my_fome/src/domain/repositories/cartItem/cart_item_repository.dart';

part 'cart_item_view_model.g.dart';

class CartItemViewModel = CartItemViewModelBase with _$CartItemViewModel;

abstract class CartItemViewModelBase with Store {
  final CartItemRepository cartItemRepository;
  final ResultMessageService resultMessageService;
  CartItemViewModelBase({
    required this.cartItemRepository,
    required this.resultMessageService,
  });

  @observable
  bool isLoading = false;

  @observable
  bool serverError = false;

  @action
  Future register(CartItemRegisterDto data) async {
    isLoading = true;
    final result = await cartItemRepository.register(data);
    result.fold((success) {
      serverError = false;
      resultMessageService.showMessageSuccess(
          TextConstant.sucessCreatingCartItemTitle,
          TextConstant.sucessCreatingCartItemMessage,
          IconConstant.success);
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorCreatingCartItemMessage);
    });
    isLoading = false;
  }
}
