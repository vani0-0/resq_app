// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      name: json['name'] as String,
      age: json['age'] as int,
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      bounty: json['bounty'] as int,
      description: json['description'] as String,
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'lastSeen': instance.lastSeen.toIso8601String(),
      'bounty': instance.bounty,
      'description': instance.description,
      'imageUrls': instance.imageUrls,
    };
