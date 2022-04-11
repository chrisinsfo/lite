import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

/*
Models a Device retrieved from the hue-api-v2
https://developers.meethue.com/develop/hue-api-v2/api-reference/#resource_device_get
 */

part 'device_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeviceModel {
  DeviceModel(this.id, this.metadata, this.services);
  @required final String id;
  @required final Metadata metadata;
  @required final List<Service> services;

  factory DeviceModel.fromJson(Map<String, dynamic>json) => _$DeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
  
  static List<DeviceModel> deserialize(List<dynamic>json) {
    return json.map((e) => DeviceModel.fromJson(e)).toList();
  }

  static List<DeviceModel> copyWith(List<DeviceModel>devices ) {
    return <DeviceModel>[...devices];
  }
}

@JsonSerializable()
class Metadata {
  Metadata(this.archetype, this.name);

  @required final String archetype;
  @required final String name;

  factory Metadata.fromJson(Map<String, dynamic>json) => _$MetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class Service {
  Service(this.rid, this.rtype);

  @required final String rid;
  @required final String rtype;

  factory Service.fromJson(Map<String, dynamic>json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
