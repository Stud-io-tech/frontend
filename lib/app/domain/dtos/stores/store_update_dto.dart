import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StoreUpdateDto {
  final String? name;
  final String? description;
  final String? image;
  final String? schedules;
  final String? pixKey;
  final bool? isDelivered;
  final String? deliveryTimeKm;
  final String? dynamicFreightKm;

  StoreUpdateDto({
    this.name,
    this.description,
    this.image,
    this.schedules,
    this.pixKey,
    this.isDelivered,
    this.deliveryTimeKm,
    this.dynamicFreightKm,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'image': image,
      'schedules': schedules,
      'pix_key': pixKey,
      'is_delivered': isDelivered,
      'delivery_time_km': deliveryTimeKm,
      'dynamic_freight_km': dynamicFreightKm,
    };
  }

  factory StoreUpdateDto.fromMap(Map<String, dynamic> map) {
    return StoreUpdateDto(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      schedules: map['schedules'] != null ? map['schedules'] as String : null,
      pixKey: map['pix_key'] != null ? map['pix_key'] as String : null,
      isDelivered:
          map['is_delivered'] != null ? map['is_delivered'] as bool : null,
      deliveryTimeKm: map['delivery_time_km'] != null
          ? map['delivery_time_km'] as String
          : null,
      dynamicFreightKm: map['dynamic_freight_km'] != null
          ? map['dynamic_freight_km'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreUpdateDto.fromJson(String source) =>
      StoreUpdateDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant StoreUpdateDto other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.image == image &&
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
        image.hashCode ^
        schedules.hashCode ^
        pixKey.hashCode ^
        isDelivered.hashCode ^
        deliveryTimeKm.hashCode ^
        dynamicFreightKm.hashCode;
  }

  @override
  String toString() {
    return 'StoreUpdateDto(name: $name, description: $description, image: $image, schedules: $schedules, pixKey: $pixKey, isDelivered: $isDelivered, deliveryTimeKm: $deliveryTimeKm, dynamicFreightKm: $dynamicFreightKm)';
  }
}
