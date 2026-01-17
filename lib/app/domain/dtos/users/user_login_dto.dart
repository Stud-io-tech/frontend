// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserLoginDto {
  final String email;
  UserLoginDto({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory UserLoginDto.fromMap(Map<String, dynamic> map) {
    return UserLoginDto(
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginDto.fromJson(String source) =>
      UserLoginDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserLoginDto other) {
    if (identical(this, other)) return true;

    return other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}