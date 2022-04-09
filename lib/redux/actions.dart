import 'package:lite/models/model.dart';
import 'package:lite/models/device_model.dart';

class WillSetConfigAction {
  final Config config;

  WillSetConfigAction(this.config);
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
  final Config config;
  List<DeviceModel> deviceList;

  GetDevicesAction(this.config, this.deviceList);
}

class FetchedDevicesAction {
  List<DeviceModel> deviceList;

  FetchedDevicesAction(this.deviceList);
}