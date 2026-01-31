// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductRegisterDto {
  final String name;
  final String description;
  final String price;
  final String amount;
  final String storeId;
  final bool isPerishable;
  final String preparationTime;
  ProductRegisterDto({
    required this.name,
    required this.description,
    required this.price,
    required this.amount,
    required this.storeId,
    required this.isPerishable,
    required this.preparationTime,
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

  factory ProductRegisterDto.fromMap(Map<String, dynamic> map) {
    return ProductRegisterDto(
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      amount: map['amount'] as String,
      storeId: map['store_id'] as String,
      isPerishable: map['is_perishable'] as bool,
      preparationTime: map['preparation_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductRegisterDto.fromJson(String source) => ProductRegisterDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ProductRegisterDto other) {
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
    return 'ProductRegisterDto(name: $name, description: $description, price: $price, amount: $amount, storeId: $storeId, isPerishable: $isPerishable, preparationTime: $preparationTime)';
  }
}
