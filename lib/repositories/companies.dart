import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'companies.g.dart';

@JsonSerializable()
class CompanyJson {
  final String name;
  final List<PositionJson> positions;

  CompanyJson({required this.name, required this.positions});

  factory CompanyJson.fromJson(Map<String, dynamic> json) =>
      _$CompanyJsonFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyJsonToJson(this);
}

@JsonSerializable()
class PositionJson {
  final String name;
  final List<String> skills;

  PositionJson({required this.name, required this.skills});

  factory PositionJson.fromJson(Map<String, dynamic> json) =>
      _$PositionJsonFromJson(json);

  Map<String, dynamic> toJson() => _$PositionJsonToJson(this);
}

List<CompanyJson> loadCompanies() {
  final file = File("companies.json");
  final content = file.readAsStringSync();
  return (json.decode(content) as List)
      .map(
        (e) => CompanyJson.fromJson(e as Map<String, dynamic>),
      )
      .toList();
}
