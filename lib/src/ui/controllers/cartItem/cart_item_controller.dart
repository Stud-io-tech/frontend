import 'package:mobx/mobx.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_group_store_dto.dart';
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

  @computed
  List<CartItemGroupStoreDto>? get cartItems =>
      cartItemViewModel.cartItemGroupStoreDto;

  @computed
  int get amountItemCart {
    List<CartItemGroupStoreDto>? groups =
        cartItemViewModel.cartItemGroupStoreDto;
    if (groups == null || groups.isEmpty) return 0;
    return groups.fold(
      0,
      (total, group) => total + group.cartItems.length,
    );
  }

  @action
  Future<void> register(CartItemRegisterDto data) async {
    await cartItemViewModel.register(data);
    await cartItemViewModel.getByGroupStoreByUser(data.userId);
  }

  @action
  Future<void> getByGroupStoreByUser(String userId) async {
    await cartItemViewModel.getByGroupStoreByUser(userId);
  }

  @action
  Future<void> updateAmount(int amount, String id, String userId) async {
    await cartItemViewModel.updateAmount(amount, id);
    await cartItemViewModel.getByGroupStoreByUser(userId);
  }

  void clean() {
    cartItemViewModel.cartItemGroupStoreDto = [];
  }
}
