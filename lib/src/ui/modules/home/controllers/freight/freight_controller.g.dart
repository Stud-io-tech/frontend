// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freight_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FreightController on FreightControllerBase, Store {
  late final _$FreightControllerBaseActionController =
      ActionController(name: 'FreightControllerBase', context: context);

  @override
  List<double> getFreight(double userLatitude, double userLongitude,
      double storeLatitude, double storeLongitude, double valueKM) {
    final _$actionInfo = _$FreightControllerBaseActionController.startAction(
        name: 'FreightControllerBase.getFreight');
    try {
      return super.getFreight(
          userLatitude, userLongitude, storeLatitude, storeLongitude, valueKM);
    } finally {
      _$FreightControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
