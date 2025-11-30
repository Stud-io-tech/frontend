// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductViewModel on ProductViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ProductViewModelBase.isLoading', context: context);

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

  late final _$productsListActiveAtom =
      Atom(name: 'ProductViewModelBase.productsListActive', context: context);

  @override
  List<ProductDetailDto>? get productsListActive {
    _$productsListActiveAtom.reportRead();
    return super.productsListActive;
  }

  @override
  set productsListActive(List<ProductDetailDto>? value) {
    _$productsListActiveAtom.reportWrite(value, super.productsListActive, () {
      super.productsListActive = value;
    });
  }

  late final _$productsListInactiveByStoreAtom = Atom(
      name: 'ProductViewModelBase.productsListInactiveByStore',
      context: context);

  @override
  List<ProductDetailDto>? get productsListInactiveByStore {
    _$productsListInactiveByStoreAtom.reportRead();
    return super.productsListInactiveByStore;
  }

  @override
  set productsListInactiveByStore(List<ProductDetailDto>? value) {
    _$productsListInactiveByStoreAtom
        .reportWrite(value, super.productsListInactiveByStore, () {
      super.productsListInactiveByStore = value;
    });
  }

  late final _$productsListActiveByStoreAtom = Atom(
      name: 'ProductViewModelBase.productsListActiveByStore', context: context);

  @override
  List<ProductDetailDto>? get productsListActiveByStore {
    _$productsListActiveByStoreAtom.reportRead();
    return super.productsListActiveByStore;
  }

  @override
  set productsListActiveByStore(List<ProductDetailDto>? value) {
    _$productsListActiveByStoreAtom
        .reportWrite(value, super.productsListActiveByStore, () {
      super.productsListActiveByStore = value;
    });
  }

  late final _$productFilterListActiveAtom = Atom(
      name: 'ProductViewModelBase.productFilterListActive', context: context);

  @override
  List<ProductDetailDto>? get productFilterListActive {
    _$productFilterListActiveAtom.reportRead();
    return super.productFilterListActive;
  }

  @override
  set productFilterListActive(List<ProductDetailDto>? value) {
    _$productFilterListActiveAtom
        .reportWrite(value, super.productFilterListActive, () {
      super.productFilterListActive = value;
    });
  }

  late final _$productFilterListInactiveByStoreAtom = Atom(
      name: 'ProductViewModelBase.productFilterListInactiveByStore',
      context: context);

  @override
  List<ProductDetailDto>? get productFilterListInactiveByStore {
    _$productFilterListInactiveByStoreAtom.reportRead();
    return super.productFilterListInactiveByStore;
  }

  @override
  set productFilterListInactiveByStore(List<ProductDetailDto>? value) {
    _$productFilterListInactiveByStoreAtom
        .reportWrite(value, super.productFilterListInactiveByStore, () {
      super.productFilterListInactiveByStore = value;
    });
  }

  late final _$productFilterListActiveByStoreAtom = Atom(
      name: 'ProductViewModelBase.productFilterListActiveByStore',
      context: context);

  @override
  List<ProductDetailDto>? get productFilterListActiveByStore {
    _$productFilterListActiveByStoreAtom.reportRead();
    return super.productFilterListActiveByStore;
  }

  @override
  set productFilterListActiveByStore(List<ProductDetailDto>? value) {
    _$productFilterListActiveByStoreAtom
        .reportWrite(value, super.productFilterListActiveByStore, () {
      super.productFilterListActiveByStore = value;
    });
  }

  late final _$productAtom =
      Atom(name: 'ProductViewModelBase.product', context: context);

  @override
  ProductDetailDto? get product {
    _$productAtom.reportRead();
    return super.product;
  }

  @override
  set product(ProductDetailDto? value) {
    _$productAtom.reportWrite(value, super.product, () {
      super.product = value;
    });
  }

  late final _$foundActiveAtom =
      Atom(name: 'ProductViewModelBase.foundActive', context: context);

  @override
  int get foundActive {
    _$foundActiveAtom.reportRead();
    return super.foundActive;
  }

  @override
  set foundActive(int value) {
    _$foundActiveAtom.reportWrite(value, super.foundActive, () {
      super.foundActive = value;
    });
  }

  late final _$foundActiveByStoreAtom =
      Atom(name: 'ProductViewModelBase.foundActiveByStore', context: context);

  @override
  int get foundActiveByStore {
    _$foundActiveByStoreAtom.reportRead();
    return super.foundActiveByStore;
  }

  @override
  set foundActiveByStore(int value) {
    _$foundActiveByStoreAtom.reportWrite(value, super.foundActiveByStore, () {
      super.foundActiveByStore = value;
    });
  }

  late final _$foundInactiveByStoreAtom =
      Atom(name: 'ProductViewModelBase.foundInactiveByStore', context: context);

  @override
  int get foundInactiveByStore {
    _$foundInactiveByStoreAtom.reportRead();
    return super.foundInactiveByStore;
  }

  @override
  set foundInactiveByStore(int value) {
    _$foundInactiveByStoreAtom.reportWrite(value, super.foundInactiveByStore,
        () {
      super.foundInactiveByStore = value;
    });
  }

  late final _$serverErrorAtom =
      Atom(name: 'ProductViewModelBase.serverError', context: context);

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

  late final _$listActiveAsyncAction =
      AsyncAction('ProductViewModelBase.listActive', context: context);

  @override
  Future<dynamic> listActive() {
    return _$listActiveAsyncAction.run(() => super.listActive());
  }

  late final _$registerAsyncAction =
      AsyncAction('ProductViewModelBase.register', context: context);

  @override
  Future<dynamic> register(ProductRegisterDto product, XFile image) {
    return _$registerAsyncAction.run(() => super.register(product, image));
  }

  late final _$updateAsyncAction =
      AsyncAction('ProductViewModelBase.update', context: context);

  @override
  Future<dynamic> update(String id, ProductUpdateDto product, {XFile? image}) {
    return _$updateAsyncAction
        .run(() => super.update(id, product, image: image));
  }

  late final _$listInactiveByStoreAsyncAction =
      AsyncAction('ProductViewModelBase.listInactiveByStore', context: context);

  @override
  Future<dynamic> listInactiveByStore(String id) {
    return _$listInactiveByStoreAsyncAction
        .run(() => super.listInactiveByStore(id));
  }

  late final _$detailAsyncAction =
      AsyncAction('ProductViewModelBase.detail', context: context);

  @override
  Future<dynamic> detail(String id) {
    return _$detailAsyncAction.run(() => super.detail(id));
  }

  late final _$ProductViewModelBaseActionController =
      ActionController(name: 'ProductViewModelBase', context: context);

  @override
  void listFilterByName(String name) {
    final _$actionInfo = _$ProductViewModelBaseActionController.startAction(
        name: 'ProductViewModelBase.listFilterByName');
    try {
      return super.listFilterByName(name);
    } finally {
      _$ProductViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
productsListActive: ${productsListActive},
productsListInactiveByStore: ${productsListInactiveByStore},
productsListActiveByStore: ${productsListActiveByStore},
productFilterListActive: ${productFilterListActive},
productFilterListInactiveByStore: ${productFilterListInactiveByStore},
productFilterListActiveByStore: ${productFilterListActiveByStore},
product: ${product},
foundActive: ${foundActive},
foundActiveByStore: ${foundActiveByStore},
foundInactiveByStore: ${foundInactiveByStore},
serverError: ${serverError}
    ''';
  }
}
