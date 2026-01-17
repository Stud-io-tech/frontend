// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_google_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthGoogleController on AuthGoogleControllerBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: 'AuthGoogleControllerBase.isLoading'))
          .value;
  Computed<bool>? _$isServerErrorComputed;

  @override
  bool get isServerError =>
      (_$isServerErrorComputed ??= Computed<bool>(() => super.isServerError,
              name: 'AuthGoogleControllerBase.isServerError'))
          .value;
  Computed<UserDetailDto?>? _$userComputed;

  @override
  UserDetailDto? get user =>
      (_$userComputed ??= Computed<UserDetailDto?>(() => super.user,
              name: 'AuthGoogleControllerBase.user'))
          .value;
  Computed<StoreDetailDto?>? _$storeComputed;

  @override
  StoreDetailDto? get store =>
      (_$storeComputed ??= Computed<StoreDetailDto?>(() => super.store,
              name: 'AuthGoogleControllerBase.store'))
          .value;

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isServerError: ${isServerError},
user: ${user},
store: ${store}
    ''';
  }
}
