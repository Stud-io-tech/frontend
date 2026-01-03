import 'package:mobx/mobx.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_register_dto.dart';
import 'package:my_fome/src/ui/viewmodels/cartItem/cart_item_view_model.dart';
part 'cart_item_controller.g.dart';

class CartItemController = CartItemControllerBase with _$CartItemController;

abstract class CartItemControllerBase with Store {
  final CartItemViewModel cartItemViewModel;
  CartItemControllerBase({
    required this.cartItemViewModel,
  });

  @computed
  bool get isLoading => cartItemViewModel.isLoading;

  @computed
  bool get isServerError => cartItemViewModel.serverError;

  @action
  Future<void> register(CartItemRegisterDto data) async {
    await cartItemViewModel.register(data);
  }
}