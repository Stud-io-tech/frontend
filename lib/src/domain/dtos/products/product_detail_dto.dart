import 'dart:convert';

class ProductDetailDto {
  final String id;
  final String name;
  final String description;
  final String image;
  final String price;
  final int amount;
  final String storeId;
  final bool active;
  final bool isPerishable;
  final int preparationTime;
  ProductDetailDto({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.amount,
    required this.price,
    required this.storeId,
    required this.active,
    required this.isPerishable,
    required this.preparationTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'amount': amount,
      'price': price,
      'store_id': storeId,
      'is_perishable': isPerishable,
      'preparation_time': preparationTime,
    };
  }

  factory ProductDetailDto.fromMap(Map<String, dynamic> map) {
    return ProductDetailDto(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      price: map['price'] as String,
      amount: map['amount'] as int,
      storeId: map['store_id'] as String,
      active: map['active'] as bool,
      isPerishable: map['is_perishable'] as bool,
      preparationTime: map['preparation_time'] as int,
    );
  }

  factory ProductDetailDto.fromJson(String source) =>
      ProductDetailDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ProductDetailDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.price == price &&
        other.active == active &&
        other.amount == amount &&
        other.isPerishable == isPerishable &&
        other.preparationTime == preparationTime &&
        other.storeId == storeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        price.hashCode ^
        active.hashCode ^
        amount.hashCode ^
        isPerishable.hashCode ^
        preparationTime.hashCode ^
        storeId.hashCode;
  }
}
