// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyJson _$CompanyJsonFromJson(Map<String, dynamic> json) => CompanyJson(
      name: json['name'] as String,
      positions: (json['positions'] as List<dynamic>)
          .map((e) => PositionJson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyJsonToJson(CompanyJson instance) =>
    <String, dynamic>{
      'name': instance.name,
      'positions': instance.positions,
    };

PositionJson _$PositionJsonFromJson(Map<String, dynamic> json) => PositionJson(
      name: json['name'] as String,
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PositionJsonToJson(PositionJson instance) =>
    <String, dynamic>{
      'name': instance.name,
      'skills': instance.skills,
    };
