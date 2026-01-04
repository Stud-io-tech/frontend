// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:my_fome/src/domain/dtos/cartItem/cart_item_detail_dto.dart';

class CartItemGroupStoreDto {
  final String storeId;
  final String storeName;
  final String total;
  final String? storeFreight;
  final String? storeLatitude;
  final String? storeLongitude;
  final bool storeIsDelivered;
  final List<CartItemDetailDto> cartItems;
  CartItemGroupStoreDto({
    required this.storeId,
    required this.storeName,
    required this.total,
    this.storeFreight,
    this.storeLatitude,
    this.storeLongitude,
    required this.storeIsDelivered,
    required this.cartItems,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'store_id': storeId,
      'store_name': storeName,
      'total': total,
      'store_freight': storeFreight,
      'store_latitude': storeLatitude,
      'store_longitude': storeLongitude,
      'store_is_delivered': storeIsDelivered,
      'cart_items': cartItems.map((x) => x.toMap()).toList(),
    };
  }

  factory CartItemGroupStoreDto.fromMap(Map<String, dynamic> map) {
    return CartItemGroupStoreDto(
      storeId: map['store_id'] as String,
      storeName: map['store_name'] as String,
      total: map['total'] as String,
      storeFreight:
          map['store_freight'] != null ? map['store_freight'] as String : null,
      storeLatitude: map['store_latitude'] != null
          ? map['store_latitude'] as String
          : null,
      storeLongitude: map['store_longitude'] != null
          ? map['store_longitude'] as String
          : null,
      storeIsDelivered: map['store_is_delivered'] as bool,
      cartItems: (map['cart_items'] as List)
          .map((e) => CartItemDetailDto.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemGroupStoreDto.fromJson(String source) =>
      CartItemGroupStoreDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant CartItemGroupStoreDto other) {
    if (identical(this, other)) return true;

    return other.storeId == storeId &&
        other.storeName == storeName &&
        other.total == total &&
        other.storeFreight == storeFreight &&
        other.storeLatitude == storeLatitude &&
        other.storeLongitude == storeLongitude &&
        other.storeIsDelivered == storeIsDelivered &&
        listEquals(other.cartItems, cartItems);
  }

  @override
  int get hashCode {
    return storeId.hashCode ^
        storeName.hashCode ^
        total.hashCode ^
        storeFreight.hashCode ^
        storeLatitude.hashCode ^
        storeLongitude.hashCode ^
        storeIsDelivered.hashCode ^
        cartItems.hashCode;
  }

  @override
  String toString() {
    return 'CartItemGroupStoreDto(storeId: $storeId, storeName: $storeName, total: $total, storeFreight: $storeFreight, storeLatitude: $storeLatitude, storeLongitude: $storeLongitude, cartItems: $cartItems, store_is_delivered: $storeIsDelivered)';
  }
}
