// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddressMapDto {
  final String? cep;
  final String? state;
  final String? city;
  final String? district;
  final String? street;
  AddressMapDto({
    this.cep,
    this.state,
    this.city,
    this.district,
    this.street,
  });

  @override
  String toString() {
    return 'AddressMapDto(cep: $cep, state: $state, city: $city, district: $district, street: $street)';
  }
}
