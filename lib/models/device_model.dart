import 'package:flutter/foundation.dart';

/*
Models a Device retrieved from the hue-api-v2
https://developers.meethue.com/develop/hue-api-v2/api-reference/#resource_device_get
 */

class DeviceModel {
  DeviceModel(this.metadata, this.services);
  
  @required final Metadata metadata;
  @required final Services services;
}

class Metadata {
  Metadata(this.archetype, this.name);

  @required final String archetype;
  @required final String name;
}

class Services {
  Services(this.services);

  @required final List<Service> services;
}

class Service {
  Service(this.rid, this.rtype);

  @required final String rid;
  @required final String rtype;
}
