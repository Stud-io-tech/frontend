// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoreViewModel on StoreViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'StoreViewModelBase.isLoading', context: context);

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

  late final _$storesListAtom =
      Atom(name: 'StoreViewModelBase.storesList', context: context);

  @override
  List<StoreDetailDto>? get storesList {
    _$storesListAtom.reportRead();
    return super.storesList;
  }

  @override
  set storesList(List<StoreDetailDto>? value) {
    _$storesListAtom.reportWrite(value, super.storesList, () {
      super.storesList = value;
    });
  }

  late final _$storeFilterListAtom =
      Atom(name: 'StoreViewModelBase.storeFilterList', context: context);

  @override
  List<StoreDetailDto>? get storeFilterList {
    _$storeFilterListAtom.reportRead();
    return super.storeFilterList;
  }

  @override
  set storeFilterList(List<StoreDetailDto>? value) {
    _$storeFilterListAtom.reportWrite(value, super.storeFilterList, () {
      super.storeFilterList = value;
    });
  }

  late final _$storeAtom =
      Atom(name: 'StoreViewModelBase.store', context: context);

  @override
  StoreDetailDto? get store {
    _$storeAtom.reportRead();
    return super.store;
  }

  @override
  set store(StoreDetailDto? value) {
    _$storeAtom.reportWrite(value, super.store, () {
      super.store = value;
    });
  }

  late final _$foundsAtom =
      Atom(name: 'StoreViewModelBase.founds', context: context);

  @override
  int get founds {
    _$foundsAtom.reportRead();
    return super.founds;
  }

  @override
  set founds(int value) {
    _$foundsAtom.reportWrite(value, super.founds, () {
      super.founds = value;
    });
  }

  late final _$serverErrorAtom =
      Atom(name: 'StoreViewModelBase.serverError', context: context);

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

  late final _$listAsyncAction =
      AsyncAction('StoreViewModelBase.list', context: context);

  @override
  Future<dynamic> list() {
    return _$listAsyncAction.run(() => super.list());
  }

  late final _$listFilterByNameAsyncAction =
      AsyncAction('StoreViewModelBase.listFilterByName', context: context);

  @override
  Future<void> listFilterByName(String name) {
    return _$listFilterByNameAsyncAction
        .run(() => super.listFilterByName(name));
  }

  late final _$registerAsyncAction =
      AsyncAction('StoreViewModelBase.register', context: context);

  @override
  Future<dynamic> register(StoreRegisterDto store, XFile image) {
    return _$registerAsyncAction.run(() => super.register(store, image));
  }

  late final _$updateAsyncAction =
      AsyncAction('StoreViewModelBase.update', context: context);

  @override
  Future<dynamic> update(String id, StoreUpdateDto store, {XFile? image}) {
    return _$updateAsyncAction.run(() => super.update(id, store, image: image));
  }

  late final _$changeStatusOpenAsyncAction =
      AsyncAction('StoreViewModelBase.changeStatusOpen', context: context);

  @override
  Future<dynamic> changeStatusOpen(String id) {
    return _$changeStatusOpenAsyncAction.run(() => super.changeStatusOpen(id));
  }

  late final _$detailAsyncAction =
      AsyncAction('StoreViewModelBase.detail', context: context);

  @override
  Future<dynamic> detail(String id) {
    return _$detailAsyncAction.run(() => super.detail(id));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
storesList: ${storesList},
storeFilterList: ${storeFilterList},
store: ${store},
founds: ${founds},
serverError: ${serverError}
    ''';
  }
}
