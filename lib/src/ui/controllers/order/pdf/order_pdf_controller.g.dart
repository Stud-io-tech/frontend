// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_pdf_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderPdfController on OrderPdfControllerBase, Store {
  Computed<bool>? _$hasPdfComputed;

  @override
  bool get hasPdf => (_$hasPdfComputed ??= Computed<bool>(() => super.hasPdf,
          name: 'OrderPdfControllerBase.hasPdf'))
      .value;

  late final _$isLoadingAtom =
      Atom(name: 'OrderPdfControllerBase.isLoading', context: context);

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

  late final _$pdfPathAtom =
      Atom(name: 'OrderPdfControllerBase.pdfPath', context: context);

  @override
  String? get pdfPath {
    _$pdfPathAtom.reportRead();
    return super.pdfPath;
  }

  @override
  set pdfPath(String? value) {
    _$pdfPathAtom.reportWrite(value, super.pdfPath, () {
      super.pdfPath = value;
    });
  }

  late final _$codeAtom =
      Atom(name: 'OrderPdfControllerBase.code', context: context);

  @override
  String? get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String? value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  late final _$generateAsyncAction =
      AsyncAction('OrderPdfControllerBase.generate', context: context);

  @override
  Future<void> generate(
      {required CartItemGroupStoreDto cart,
      required AddressDetailDto address,
      required String userName}) {
    return _$generateAsyncAction.run(
        () => super.generate(cart: cart, address: address, userName: userName));
  }

  late final _$OrderPdfControllerBaseActionController =
      ActionController(name: 'OrderPdfControllerBase', context: context);

  @override
  void clear() {
    final _$actionInfo = _$OrderPdfControllerBaseActionController.startAction(
        name: 'OrderPdfControllerBase.clear');
    try {
      return super.clear();
    } finally {
      _$OrderPdfControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
pdfPath: ${pdfPath},
code: ${code},
hasPdf: ${hasPdf}
    ''';
  }
}
