import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressUserRegisterDto {
  final String userId;
  final String cep;
  final String state;
  final String city;
  final String district;
  final String street;
  final String? complement;
  final String number;
  final String whatsapp;
  final double? latitude;
  final double? longitude;
  AddressUserRegisterDto({
    required this.userId,
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
      'user_id': userId,
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

  factory AddressUserRegisterDto.fromMap(Map<String, dynamic> map) {
    return AddressUserRegisterDto(
      userId: map['user_id'] as String,
      cep: map['cep'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      district: map['district'] as String,
      street: map['street'] as String,
      complement: map['complement'] != null ? map['complement'] as String : null,
      number: map['number'] as String,
      whatsapp: map['whatsapp'] as String,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressUserRegisterDto.fromJson(String source) => AddressUserRegisterDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant AddressUserRegisterDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
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
    return 'AddressUserRegisterDto(userId: $userId, cep: $cep, state: $state, city: $city, district: $district, street: $street, complement: $complement, number: $number, whatsapp: $whatsapp, latitude: $latitude, longitude: $longitude)';
  }
}
