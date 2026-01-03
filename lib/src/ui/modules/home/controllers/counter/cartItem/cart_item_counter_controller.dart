import 'package:mobx/mobx.dart';
part 'cart_item_counter_controller.g.dart';

class CartItemCounterController = CartItemCounterControllerBase
    with _$CartItemCounterController;

abstract class CartItemCounterControllerBase with Store {
  @observable
  int value = 1;

  @observable
  double price = 0.0;

  @computed
  double get totalValue => value * price;

  @action
  void setPrice(double newPrice) {
    price = newPrice;
  }

  @action
  void increment(int amount) {
    if (value < amount) {
      value = value + 1;
    }
  }

  @action
  void decrement() {
    if (value > 1) {
      value = value - 1;
    }
  }

  void cleanValue() {
    value = 1;
  }

  @action
  void incrementCart(int newValue, int amount) {
    if (newValue < amount) {
      newValue = newValue + 1;
    }
  }

  void decrementCart(int newValue) {
    if (newValue > 1) {
      newValue = newValue - 1;
    }
  }
}
