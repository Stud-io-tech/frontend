import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class CartItemRegisterDto {
  final String userId;
  final String productId;
  final int amount;
  CartItemRegisterDto({
    required this.userId,
    required this.productId,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'product_id': productId,
      'amount': amount,
    };
  }

  factory CartItemRegisterDto.fromMap(Map<String, dynamic> map) {
    return CartItemRegisterDto(
      userId: map['user_id'] as String,
      productId: map['product_id'] as String,
      amount: map['amount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemRegisterDto.fromJson(String source) => CartItemRegisterDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant CartItemRegisterDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.productId == productId &&
      other.amount == amount;
  }

  @override
  int get hashCode => userId.hashCode ^ productId.hashCode ^ amount.hashCode;

  @override
  String toString() => 'CartItemRegisterDto(userId: $userId, productId: $productId, amount: $amount)';
}
