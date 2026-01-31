// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SwitchController on SwitchControllerBase, Store {
  late final _$valueAtom =
      Atom(name: 'SwitchControllerBase.value', context: context);

  @override
  bool get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(bool value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$SwitchControllerBaseActionController =
      ActionController(name: 'SwitchControllerBase', context: context);

  @override
  void toggleValue() {
    final _$actionInfo = _$SwitchControllerBaseActionController.startAction(
        name: 'SwitchControllerBase.toggleValue');
    try {
      return super.toggleValue();
    } finally {
      _$SwitchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setValue(bool newValue) {
    final _$actionInfo = _$SwitchControllerBaseActionController.startAction(
        name: 'SwitchControllerBase.setValue');
    try {
      return super.setValue(newValue);
    } finally {
      _$SwitchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
