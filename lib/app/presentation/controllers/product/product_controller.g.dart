// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductController on ProductControllerBase, Store {
  Computed<ProductDetailDto?>? _$productComputed;

  @override
  ProductDetailDto? get product =>
      (_$productComputed ??= Computed<ProductDetailDto?>(() => super.product,
              name: 'ProductControllerBase.product'))
          .value;
  Computed<int>? _$activeFoundsComputed;

  @override
  int get activeFounds =>
      (_$activeFoundsComputed ??= Computed<int>(() => super.activeFounds,
              name: 'ProductControllerBase.activeFounds'))
          .value;
  Computed<int>? _$activeFoundsByStoreComputed;

  @override
  int get activeFoundsByStore => (_$activeFoundsByStoreComputed ??=
          Computed<int>(() => super.activeFoundsByStore,
              name: 'ProductControllerBase.activeFoundsByStore'))
      .value;
  Computed<int>? _$inactiveFoundsByStoreComputed;

  @override
  int get inactiveFoundsByStore => (_$inactiveFoundsByStoreComputed ??=
          Computed<int>(() => super.inactiveFoundsByStore,
              name: 'ProductControllerBase.inactiveFoundsByStore'))
      .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: 'ProductControllerBase.isLoading'))
          .value;
  Computed<bool>? _$isServerErrorComputed;

  @override
  bool get isServerError =>
      (_$isServerErrorComputed ??= Computed<bool>(() => super.isServerError,
              name: 'ProductControllerBase.isServerError'))
          .value;
  Computed<List<ProductDetailDto>?>? _$productFilterListActiveComputed;

  @override
  List<ProductDetailDto>? get productFilterListActive =>
      (_$productFilterListActiveComputed ??= Computed<List<ProductDetailDto>?>(
              () => super.productFilterListActive,
              name: 'ProductControllerBase.productFilterListActive'))
          .value;
  Computed<List<ProductDetailDto>?>? _$productFilterListInactiveByStoreComputed;

  @override
  List<ProductDetailDto>? get productFilterListInactiveByStore =>
      (_$productFilterListInactiveByStoreComputed ??=
              Computed<List<ProductDetailDto>?>(
                  () => super.productFilterListInactiveByStore,
                  name:
                      'ProductControllerBase.productFilterListInactiveByStore'))
          .value;
  Computed<List<ProductDetailDto>?>? _$productFilterListActiveByStoreComputed;

  @override
  List<ProductDetailDto>? get productFilterListActiveByStore =>
      (_$productFilterListActiveByStoreComputed ??=
              Computed<List<ProductDetailDto>?>(
                  () => super.productFilterListActiveByStore,
                  name: 'ProductControllerBase.productFilterListActiveByStore'))
          .value;

  @override
  String toString() {
    return '''
product: ${product},
activeFounds: ${activeFounds},
activeFoundsByStore: ${activeFoundsByStore},
inactiveFoundsByStore: ${inactiveFoundsByStore},
isLoading: ${isLoading},
isServerError: ${isServerError},
productFilterListActive: ${productFilterListActive},
productFilterListInactiveByStore: ${productFilterListInactiveByStore},
productFilterListActiveByStore: ${productFilterListActiveByStore}
    ''';
  }
}
