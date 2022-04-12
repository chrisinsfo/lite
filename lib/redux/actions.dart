import 'package:lite/models/model.dart';
import 'package:lite/models/device_model.dart';

class Action {
  @override
  String toString() {
    return runtimeType.toString();
  }
}

class SetConfigAction extends Action {
  final Config config;

  SetConfigAction(this.config);
}

class ValidConfigAction extends Action {
  final Config config;

  ValidConfigAction(this.config);
}

class ToggleLightAction extends Action {
  String lightId;

  ToggleLightAction(this.lightId);
}

class UpdatedLightStateAction extends Action {
  final Map<String, bool> lightsStateCache;

  UpdatedLightStateAction(this.lightsStateCache);
}

class GetLightsStateAction extends Action {
  final Map<String, bool> lightsStateCache;

  GetLightsStateAction(this.lightsStateCache);
}

class FetchedLightsStateAction extends Action {
  final Map<String, bool> lightsStateCache;

  FetchedLightsStateAction(this.lightsStateCache);
}

class GetDevicesAction extends Action {
  List<DeviceModel> deviceList;

  GetDevicesAction(this.deviceList);
}

class FetchedDevicesAction extends Action {
  List<DeviceModel> deviceList;

  FetchedDevicesAction(this.deviceList);
}
