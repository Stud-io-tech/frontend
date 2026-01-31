// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PaymentPixDto extends Equatable {
  final String keyPix;
  final String name;
  final String city;
  final String value;
  const PaymentPixDto({
    required this.keyPix,
    required this.name,
    required this.city,
    required this.value,
  });
  @override
  List<Object?> get props => [keyPix, name, city, value];
}
