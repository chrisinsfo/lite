import 'package:flutter/foundation.dart';

/*
Models a Device retrieved from the hue-api-v2
https://developers.meethue.com/develop/hue-api-v2/api-reference/#resource_device_get
 */

class DeviceModel {
  DeviceModel(this.metadata, this.services);

  @required final Metadata metadata;
  @required final Services services;

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
        Metadata.fromJson(json['metadata']),
        Services.fromJson(json['services'])
    );
  }
}

class Metadata {
  Metadata(this.archetype, this.name);

  @required final String archetype;
  @required final String name;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      json['archetype'],
      json['name']
    );
  }
}

class Services {
  Services(this.services);

  @required final List<Service> services;

  factory Services.fromJson(List<Map<String, dynamic>> json) {
    final List<Service> services = []..length = 0;

    for (var service in json) {
      services.add(Service.fromJson(service));
    }

    return Services(services);
  }
}

class Service {
  Service(this.rid, this.rtype);

  @required final String rid;
  @required final String rtype;

  factory Service.fromJson(Map<String, dynamic>json) {
    return Service(
      json['rid'],
      json['rtype']
    );
  }
}
