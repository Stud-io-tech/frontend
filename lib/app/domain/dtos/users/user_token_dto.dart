// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserTokenDto {
  final String? accessToken;
  final String? refreshToken;
  UserTokenDto({
    this.accessToken,
    this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  factory UserTokenDto.fromMap(Map<String, dynamic> map) {
    return UserTokenDto(
      accessToken: map['access_token'] != null ? map['access_token'] as String : null,
      refreshToken: map['refresh_token'] != null ? map['refresh_token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTokenDto.fromJson(String source) => UserTokenDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
