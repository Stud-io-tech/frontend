// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserRegisterDto {
  final String name;
  final String email;
  final String? image;
  UserRegisterDto({
    required this.name,
    required this.email,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
    };
  }

  factory UserRegisterDto.fromMap(Map<String, dynamic> map) {
    return UserRegisterDto(
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRegisterDto.fromJson(String source) => UserRegisterDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserRegisterDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ image.hashCode;
}
