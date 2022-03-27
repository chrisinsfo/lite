// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      (json['services'] as List<dynamic>)
          .map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'metadata': instance.metadata.toJson(),
      'services': instance.services.map((e) => e.toJson()).toList(),
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      json['archetype'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'archetype': instance.archetype,
      'name': instance.name,
    };

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      json['rid'] as String,
      json['rtype'] as String,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'rid': instance.rid,
      'rtype': instance.rtype,
    };
