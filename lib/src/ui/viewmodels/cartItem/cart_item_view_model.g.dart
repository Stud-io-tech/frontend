// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartItemViewModel on CartItemViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'CartItemViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$serverErrorAtom =
      Atom(name: 'CartItemViewModelBase.serverError', context: context);

  @override
  bool get serverError {
    _$serverErrorAtom.reportRead();
    return super.serverError;
  }

  @override
  set serverError(bool value) {
    _$serverErrorAtom.reportWrite(value, super.serverError, () {
      super.serverError = value;
    });
  }

  late final _$cartItemGroupStoreDtoAtom = Atom(
      name: 'CartItemViewModelBase.cartItemGroupStoreDto', context: context);

  @override
  List<CartItemGroupStoreDto>? get cartItemGroupStoreDto {
    _$cartItemGroupStoreDtoAtom.reportRead();
    return super.cartItemGroupStoreDto;
  }

  @override
  set cartItemGroupStoreDto(List<CartItemGroupStoreDto>? value) {
    _$cartItemGroupStoreDtoAtom.reportWrite(value, super.cartItemGroupStoreDto,
        () {
      super.cartItemGroupStoreDto = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('CartItemViewModelBase.register', context: context);

  @override
  Future<dynamic> register(CartItemRegisterDto data) {
    return _$registerAsyncAction.run(() => super.register(data));
  }

  late final _$updateAmountAsyncAction =
      AsyncAction('CartItemViewModelBase.updateAmount', context: context);

  @override
  Future<dynamic> updateAmount(int amount, String id) {
    return _$updateAmountAsyncAction.run(() => super.updateAmount(amount, id));
  }

  late final _$getByGroupStoreByUserAsyncAction = AsyncAction(
      'CartItemViewModelBase.getByGroupStoreByUser',
      context: context);

  @override
  Future<dynamic> getByGroupStoreByUser(String userId) {
    return _$getByGroupStoreByUserAsyncAction
        .run(() => super.getByGroupStoreByUser(userId));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
serverError: ${serverError},
cartItemGroupStoreDto: ${cartItemGroupStoreDto}
    ''';
  }
}
