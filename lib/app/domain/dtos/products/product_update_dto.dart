// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductUpdateDto {
  final String? name;
  final String? description;
  final String? price;
  final String? amount;
  final String? storeId;
  final bool isPerishable;
  final int? preparationTime;
  ProductUpdateDto({
    this.name,
    this.description,
    this.price,
    this.amount,
    this.storeId,
    required this.isPerishable,
    this.preparationTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'amount': amount,
      'store_id': storeId,
      'is_perishable': isPerishable,
      'preparation_time': preparationTime,
    };
  }

  factory ProductUpdateDto.fromMap(Map<String, dynamic> map) {
    return ProductUpdateDto(
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      storeId: map['store_id'] != null ? map['store_id'] as String : null,
      isPerishable: map['is_perishable'] as bool,
      preparationTime: map['preparation_time'] != null ? map['preparation_time'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductUpdateDto.fromJson(String source) =>
      ProductUpdateDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ProductUpdateDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.description == description &&
      other.price == price &&
      other.amount == amount &&
      other.storeId == storeId &&
      other.isPerishable == isPerishable &&
      other.preparationTime == preparationTime;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      amount.hashCode ^
      storeId.hashCode ^
      isPerishable.hashCode ^
      preparationTime.hashCode;
  }

  @override
  String toString() {
    return 'ProductUpdateDto(name: $name, description: $description, price: $price, amount: $amount, storeId: $storeId, isPerishable: $isPerishable, preparationTime: $preparationTime)';
  }
}
