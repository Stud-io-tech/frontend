import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StoreUpdateDto {
  final String? name;
  final String? description;
  final String? whatsapp;
  final String? chavePix;

  StoreUpdateDto({
    this.name,
    this.description,
    this.whatsapp,
    this.chavePix,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'whatsapp': whatsapp,
      'chave_pix': chavePix,
    };
  }

  factory StoreUpdateDto.fromMap(Map<String, dynamic> map) {
    return StoreUpdateDto(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      whatsapp: map['whatsapp'] != null ? map['whatsapp'] as String : null,
      chavePix: map['chave_pix'] != null ? map['chave_pix'] as String : null,
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
        other.whatsapp == whatsapp &&
        other.chavePix == chavePix;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        whatsapp.hashCode ^
        chavePix.hashCode;
  }

  @override
  String toString() {
    return 'StoreUpdateDto(name: $name, description: $description, whatsapp: $whatsapp, chavePix: $chavePix)';
  }
}
