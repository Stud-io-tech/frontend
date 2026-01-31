// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressController on AddressControllerBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: 'AddressControllerBase.isLoading'))
          .value;
  Computed<bool>? _$isServerErrorComputed;

  @override
  bool get isServerError =>
      (_$isServerErrorComputed ??= Computed<bool>(() => super.isServerError,
              name: 'AddressControllerBase.isServerError'))
          .value;
  Computed<AddressDetailDto?>? _$addressUserComputed;

  @override
  AddressDetailDto? get addressUser => (_$addressUserComputed ??=
          Computed<AddressDetailDto?>(() => super.addressUser,
              name: 'AddressControllerBase.addressUser'))
      .value;
  Computed<AddressDetailDto?>? _$addressStoreComputed;

  @override
  AddressDetailDto? get addressStore => (_$addressStoreComputed ??=
          Computed<AddressDetailDto?>(() => super.addressStore,
              name: 'AddressControllerBase.addressStore'))
      .value;

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isServerError: ${isServerError},
addressUser: ${addressUser},
addressStore: ${addressStore}
    ''';
  }
}
