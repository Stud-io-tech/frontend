// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StoreRegisterDto {
  final String name;
  final String description;
  final String schedules;
  final String pixKey;
  final bool isDelivered;
  final String? deliveryTimeKm;
  final double? dynamicFreightKm;
  StoreRegisterDto({
    required this.name,
    required this.description,
    required this.schedules,
    required this.pixKey,
    required this.isDelivered,
    this.deliveryTimeKm,
    this.dynamicFreightKm,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'schedules': schedules,
      'pixKey': pixKey,
      'isDelivered': isDelivered,
      'deliveryTimeKm': deliveryTimeKm,
      'dynamicFreightKm': dynamicFreightKm,
    };
  }

  factory StoreRegisterDto.fromMap(Map<String, dynamic> map) {
    return StoreRegisterDto(
      name: map['name'] as String,
      description: map['description'] as String,
      schedules: map['schedules'] as String,
      pixKey: map['pix_key'] as String,
      isDelivered: map['is_delivered'] as bool,
      deliveryTimeKm: map['delivery_time_km'] != null ? map['delivery_time_km'] as String : null,
      dynamicFreightKm: map['dynamic_freight_Km'] != null ? map['dynamic_freight_km'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreRegisterDto.fromJson(String source) => StoreRegisterDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant StoreRegisterDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.description == description &&
      other.schedules == schedules &&
      other.pixKey == pixKey &&
      other.isDelivered == isDelivered &&
      other.deliveryTimeKm == deliveryTimeKm &&
      other.dynamicFreightKm == dynamicFreightKm;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      description.hashCode ^
      schedules.hashCode ^
      pixKey.hashCode ^
      isDelivered.hashCode ^
      deliveryTimeKm.hashCode ^
      dynamicFreightKm.hashCode;
  }

  @override
  String toString() {
    return 'StoreRegisterDto(name: $name, description: $description, schedules: $schedules, pixKey: $pixKey, isDelivered: $isDelivered, deliveryTimeKm: $deliveryTimeKm, dynamicFreightKm: $dynamicFreightKm)';
  }
}
