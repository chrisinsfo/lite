import 'package:lite/models/model.dart';
import 'package:lite/models/device_model.dart';

class SetConfigAction {
  final Config config;

  SetConfigAction(this.config);
}

class ToggleLightAction {
  String lightId;

  ToggleLightAction(this.lightId);
}

class UpdatedLightStateAction {
  final Map<String, bool> lightsStateCache;

  UpdatedLightStateAction(this.lightsStateCache);
}

class GetLightsStateAction {
  final Map<String, bool> lightsStateCache;

  GetLightsStateAction(this.lightsStateCache);
}

class FetchedLightsStateAction {
  final Map<String, bool> lightsStateCache;

  FetchedLightsStateAction(this.lightsStateCache);
}

class GetDevicesAction {
  List<DeviceModel> deviceList;

  GetDevicesAction(this.deviceList);
}

class FetchedDevicesAction {
  List<DeviceModel> deviceList;

  FetchedDevicesAction(this.deviceList);
}