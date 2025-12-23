// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_map_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressMapController on AddressMapControllerBase, Store {
  late final _$latitudeAtom =
      Atom(name: 'AddressMapControllerBase.latitude', context: context);

  @override
  double get latitude {
    _$latitudeAtom.reportRead();
    return super.latitude;
  }

  @override
  set latitude(double value) {
    _$latitudeAtom.reportWrite(value, super.latitude, () {
      super.latitude = value;
    });
  }

  late final _$longitudeAtom =
      Atom(name: 'AddressMapControllerBase.longitude', context: context);

  @override
  double get longitude {
    _$longitudeAtom.reportRead();
    return super.longitude;
  }

  @override
  set longitude(double value) {
    _$longitudeAtom.reportWrite(value, super.longitude, () {
      super.longitude = value;
    });
  }

  late final _$searchTextAtom =
      Atom(name: 'AddressMapControllerBase.searchText', context: context);

  @override
  String? get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String? value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  late final _$addressMapAtom =
      Atom(name: 'AddressMapControllerBase.addressMap', context: context);

  @override
  AddressMapDto? get addressMap {
    _$addressMapAtom.reportRead();
    return super.addressMap;
  }

  @override
  set addressMap(AddressMapDto? value) {
    _$addressMapAtom.reportWrite(value, super.addressMap, () {
      super.addressMap = value;
    });
  }

  late final _$getCurrentPositionAsyncAction = AsyncAction(
      'AddressMapControllerBase.getCurrentPosition',
      context: context);

  @override
  Future<void> getCurrentPosition() {
    return _$getCurrentPositionAsyncAction
        .run(() => super.getCurrentPosition());
  }

  late final _$searchAddressAsyncAction =
      AsyncAction('AddressMapControllerBase.searchAddress', context: context);

  @override
  Future<void> searchAddress() {
    return _$searchAddressAsyncAction.run(() => super.searchAddress());
  }

  late final _$reverseAddressAsyncAction =
      AsyncAction('AddressMapControllerBase.reverseAddress', context: context);

  @override
  Future<void> reverseAddress(LatLng point) {
    return _$reverseAddressAsyncAction.run(() => super.reverseAddress(point));
  }

  late final _$AddressMapControllerBaseActionController =
      ActionController(name: 'AddressMapControllerBase', context: context);

  @override
  void onTapMap(LatLng point) {
    final _$actionInfo = _$AddressMapControllerBaseActionController.startAction(
        name: 'AddressMapControllerBase.onTapMap');
    try {
      return super.onTapMap(point);
    } finally {
      _$AddressMapControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
latitude: ${latitude},
longitude: ${longitude},
searchText: ${searchText},
addressMap: ${addressMap}
    ''';
  }
}
