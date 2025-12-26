// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StoreDetailDto {
  final String id;
  final String userId;
  final String name;
  final String description;
  final String image;
  final String schedules;
  final String pixKey;
  final bool isDelivered;
  final int? deliveryTimeKm;
  final String? dynamicFreightKm;
  final bool isOpen;

  StoreDetailDto({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.image,
    required this.schedules,
    required this.pixKey,
    required this.isDelivered,
    this.deliveryTimeKm,
    this.dynamicFreightKm,
    required this.isOpen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'description': description,
      'image': image,
      'schedules': schedules,
      'pix_key': pixKey,
      'is_delivered': isDelivered,
      'delivery_time_km': deliveryTimeKm,
      'dynamic_freight_km': dynamicFreightKm,
      'is_open': isOpen,
    };
  }

  factory StoreDetailDto.fromMap(Map<String, dynamic> map) {
    return StoreDetailDto(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      schedules: map['schedules'] as String,
      pixKey: map['pix_key'] as String,
      isDelivered: map['is_delivered'] as bool,
      deliveryTimeKm: map['delivery_time_km'] != null ? map['delivery_time_km'] as int : null,
      dynamicFreightKm: map['dynamic_freight_km'] != null ? map['dynamic_freight_km'] as String : null,
      isOpen: map['is_open'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreDetailDto.fromJson(String source) => StoreDetailDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant StoreDetailDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId &&
      other.name == name &&
      other.description == description &&
      other.image == image &&
      other.schedules == schedules &&
      other.pixKey == pixKey &&
      other.isDelivered == isDelivered &&
      other.deliveryTimeKm == deliveryTimeKm &&
      other.dynamicFreightKm == dynamicFreightKm &&
      other.isOpen == isOpen;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      image.hashCode ^
      schedules.hashCode ^
      pixKey.hashCode ^
      isDelivered.hashCode ^
      deliveryTimeKm.hashCode ^
      dynamicFreightKm.hashCode ^
      isOpen.hashCode;
  }

  @override
  String toString() {
    return 'StoreDetailDto(id: $id, userId: $userId, name: $name, description: $description, image: $image, schedules: $schedules, pixKey: $pixKey, isDelivered: $isDelivered, deliveryTimeKm: $deliveryTimeKm, dynamicFreightKm: $dynamicFreightKm, isOpen: $isOpen)';
  }
}
