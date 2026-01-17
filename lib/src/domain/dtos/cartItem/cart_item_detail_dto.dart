import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItemDetailDto {
  final String id;
  final String? userId;
  final String productId;
  final int amount;
  final bool? active;
  final String? price;
  final String? image;
  final String? name;
  CartItemDetailDto({
    required this.id,
    this.userId,
    required this.productId,
    required this.amount,
    this.active,
    this.price,
    this.image,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'amount': amount,
      'active': active,
      'price': price,
      'image': image,
      'name': name,
    };
  }

  factory CartItemDetailDto.fromMap(Map<String, dynamic> map) {
    return CartItemDetailDto(
        id: map['id'] as String,
        userId: map['user_id'] != null ? map['user_id'] as String : null,
        productId: map['product_id'] as String,
        amount: map['amount'] as int,
        active: map['active'] != null ? map['active'] as bool : null,
        price: map['price'] != null ? map['price'] as String : null,
        image: map['image'] != null ? map['image'] as String : null,
        name: map['name'] != null ? map['name'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory CartItemDetailDto.fromJson(String source) =>
      CartItemDetailDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant CartItemDetailDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.productId == productId &&
        other.amount == amount &&
        other.active == active &&
        other.price == price &&
        other.image == image &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        productId.hashCode ^
        amount.hashCode ^
        active.hashCode ^
        price.hashCode ^
        image.hashCode ^
        name.hashCode;
  }

  @override
  String toString() {
    return 'CartItemDetailDto(id: $id, userId: $userId, productId: $productId, amount: $amount, active: $active, price: $price, image: $image, name: $name)';
  }
}
