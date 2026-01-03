// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartItemController on CartItemControllerBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: 'CartItemControllerBase.isLoading'))
          .value;
  Computed<bool>? _$isServerErrorComputed;

  @override
  bool get isServerError =>
      (_$isServerErrorComputed ??= Computed<bool>(() => super.isServerError,
              name: 'CartItemControllerBase.isServerError'))
          .value;

  late final _$registerAsyncAction =
      AsyncAction('CartItemControllerBase.register', context: context);

  @override
  Future<void> register(CartItemRegisterDto data) {
    return _$registerAsyncAction.run(() => super.register(data));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isServerError: ${isServerError}
    ''';
  }
}
