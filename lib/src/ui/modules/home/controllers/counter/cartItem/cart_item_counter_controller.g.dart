// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_counter_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartItemCounterController on CartItemCounterControllerBase, Store {
  Computed<double>? _$totalValueComputed;

  @override
  double get totalValue =>
      (_$totalValueComputed ??= Computed<double>(() => super.totalValue,
              name: 'CartItemCounterControllerBase.totalValue'))
          .value;

  late final _$valueAtom =
      Atom(name: 'CartItemCounterControllerBase.value', context: context);

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$priceAtom =
      Atom(name: 'CartItemCounterControllerBase.price', context: context);

  @override
  double get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(double value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  late final _$CartItemCounterControllerBaseActionController =
      ActionController(name: 'CartItemCounterControllerBase', context: context);

  @override
  void setPrice(double newPrice) {
    final _$actionInfo = _$CartItemCounterControllerBaseActionController
        .startAction(name: 'CartItemCounterControllerBase.setPrice');
    try {
      return super.setPrice(newPrice);
    } finally {
      _$CartItemCounterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment(int amount) {
    final _$actionInfo = _$CartItemCounterControllerBaseActionController
        .startAction(name: 'CartItemCounterControllerBase.increment');
    try {
      return super.increment(amount);
    } finally {
      _$CartItemCounterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement() {
    final _$actionInfo = _$CartItemCounterControllerBaseActionController
        .startAction(name: 'CartItemCounterControllerBase.decrement');
    try {
      return super.decrement();
    } finally {
      _$CartItemCounterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementCart(int newValue, int amount) {
    final _$actionInfo = _$CartItemCounterControllerBaseActionController
        .startAction(name: 'CartItemCounterControllerBase.incrementCart');
    try {
      return super.incrementCart(newValue, amount);
    } finally {
      _$CartItemCounterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
price: ${price},
totalValue: ${totalValue}
    ''';
  }
}
