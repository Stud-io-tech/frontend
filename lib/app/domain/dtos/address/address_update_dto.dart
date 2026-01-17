import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressUpdateDto {
  final String? userId;
  final String? storeId;
  final String? cep;
  final String? state;
  final String? city;
  final String? district;
  final String? street;
  final String? complement;
  final String? number;
  final String? whatsapp;
  final String? latitude;
  final String? longitude;
  AddressUpdateDto({
    this.userId,
    this.storeId,
    this.cep,
    this.state,
    this.city,
    this.district,
    this.street,
    this.complement,
    this.number,
    this.whatsapp,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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

  factory AddressUpdateDto.fromMap(Map<String, dynamic> map) {
    return AddressUpdateDto(
      userId: map['user_id'] != null ? map['user_id'] as String : null,
      storeId: map['store_id'] != null ? map['store_id'] as String : null,
      cep: map['cep'] != null ? map['cep'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      street: map['street'] != null ? map['street'] as String : null,
      complement: map['complement'] != null ? map['complement'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      whatsapp: map['whatsapp'] != null ? map['whatsapp'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressUpdateDto.fromJson(String source) =>
      AddressUpdateDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant AddressUpdateDto other) {
    if (identical(this, other)) return true;
  
    return 
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
    return userId.hashCode ^
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

  @override
  String toString() {
    return 'AddressUpdateDto(userId: $userId, storeId: $storeId, cep: $cep, state: $state, city: $city, district: $district, street: $street, complement: $complement, number: $number, whatsapp: $whatsapp, latitude: $latitude, longitude: $longitude)';
  }
}
