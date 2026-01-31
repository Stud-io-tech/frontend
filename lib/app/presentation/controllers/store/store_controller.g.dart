// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoreController on StoreControllerBase, Store {
  Computed<int>? _$foundsComputed;

  @override
  int get founds => (_$foundsComputed ??=
          Computed<int>(() => super.founds, name: 'StoreControllerBase.founds'))
      .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: 'StoreControllerBase.isLoading'))
          .value;
  Computed<bool>? _$isServerErrorComputed;

  @override
  bool get isServerError =>
      (_$isServerErrorComputed ??= Computed<bool>(() => super.isServerError,
              name: 'StoreControllerBase.isServerError'))
          .value;
  Computed<List<StoreDetailDto>?>? _$storesComputed;

  @override
  List<StoreDetailDto>? get stores =>
      (_$storesComputed ??= Computed<List<StoreDetailDto>?>(() => super.stores,
              name: 'StoreControllerBase.stores'))
          .value;
  Computed<StoreDetailDto?>? _$storeComputed;

  @override
  StoreDetailDto? get store =>
      (_$storeComputed ??= Computed<StoreDetailDto?>(() => super.store,
              name: 'StoreControllerBase.store'))
          .value;

  @override
  String toString() {
    return '''
founds: ${founds},
isLoading: ${isLoading},
isServerError: ${isServerError},
stores: ${stores},
store: ${store}
    ''';
  }
}
