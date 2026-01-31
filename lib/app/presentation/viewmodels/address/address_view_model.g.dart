// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressViewModel on AddressViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'AddressViewModelBase.isLoading', context: context);

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

  late final _$addressUserAtom =
      Atom(name: 'AddressViewModelBase.addressUser', context: context);

  @override
  AddressDetailDto? get addressUser {
    _$addressUserAtom.reportRead();
    return super.addressUser;
  }

  @override
  set addressUser(AddressDetailDto? value) {
    _$addressUserAtom.reportWrite(value, super.addressUser, () {
      super.addressUser = value;
    });
  }

  late final _$addressStoreAtom =
      Atom(name: 'AddressViewModelBase.addressStore', context: context);

  @override
  AddressDetailDto? get addressStore {
    _$addressStoreAtom.reportRead();
    return super.addressStore;
  }

  @override
  set addressStore(AddressDetailDto? value) {
    _$addressStoreAtom.reportWrite(value, super.addressStore, () {
      super.addressStore = value;
    });
  }

  late final _$serverErrorAtom =
      Atom(name: 'AddressViewModelBase.serverError', context: context);

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

  late final _$registerAsyncAction =
      AsyncAction('AddressViewModelBase.register', context: context);

  @override
  Future<dynamic> register(AddressRegisterDto data) {
    return _$registerAsyncAction.run(() => super.register(data));
  }

  late final _$updateAsyncAction =
      AsyncAction('AddressViewModelBase.update', context: context);

  @override
  Future<dynamic> update(String id, AddressUpdateDto data) {
    return _$updateAsyncAction.run(() => super.update(id, data));
  }

  late final _$detailAddressUserAsyncAction =
      AsyncAction('AddressViewModelBase.detailAddressUser', context: context);

  @override
  Future<dynamic> detailAddressUser(String id) {
    return _$detailAddressUserAsyncAction
        .run(() => super.detailAddressUser(id));
  }

  late final _$detailAddressStoreAsyncAction =
      AsyncAction('AddressViewModelBase.detailAddressStore', context: context);

  @override
  Future<dynamic> detailAddressStore(String id) {
    return _$detailAddressStoreAsyncAction
        .run(() => super.detailAddressStore(id));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
addressUser: ${addressUser},
addressStore: ${addressStore},
serverError: ${serverError}
    ''';
  }
}
