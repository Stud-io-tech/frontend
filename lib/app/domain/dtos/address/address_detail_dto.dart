import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressDetailDto {
  final String id;
  final String? userId;
  final String? storeId;
  final String cep;
  final String state;
  final String city;
  final String district;
  final String street;
  final String? complement;
  final String number;
  final String whatsapp;
  final String? latitude;
  final String? longitude;
  AddressDetailDto({
    required this.id,
    this.userId,
    this.storeId,
    required this.cep,
    required this.state,
    required this.city,
    required this.district,
    required this.street,
    this.complement,
    required this.number,
    required this.whatsapp,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'store_id': storeId,
      'cep': cep,
      'state': state,
      'city': city,
      'district': district,
      'street': street,
      'complement': complement,
      'number': number,
      'whatsapp': whatsapp,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AddressDetailDto.fromMap(Map<String, dynamic> map) {
    return AddressDetailDto(
      id: map['id'] as String,
      userId: map['user_id'] != null ? map['user_id'] as String : null,
      storeId: map['store_id'] != null ? map['store_id'] as String : null,
      cep: map['cep'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      district: map['district'] as String,
      street: map['street'] as String,
      complement:
          map['complement'] != null ? map['complement'] as String : null,
      number: map['number'] as String,
      whatsapp: map['whatsapp'] as String,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressDetailDto.fromJson(String source) =>
      AddressDetailDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant AddressDetailDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.storeId == storeId &&
        other.cep == cep &&
        other.state == state &&
        other.city == city &&
        other.district == district &&
        other.street == street &&
        other.complement == complement &&
        other.number == number &&
        other.whatsapp == whatsapp &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        storeId.hashCode ^
        cep.hashCode ^
        state.hashCode ^
        city.hashCode ^
        district.hashCode ^
        street.hashCode ^
        complement.hashCode ^
        number.hashCode ^
        whatsapp.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
