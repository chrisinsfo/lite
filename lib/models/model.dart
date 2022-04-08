import 'package:lite/models/device_model.dart';

// represent whole app state
class AppState {
  final Config config;
  final List<DeviceModel> deviceList;
  // can be evolved to handle more complex state
  final Map<String, bool> lightsStateCache;

  AppState(this.config, this.deviceList, this.lightsStateCache);

  AppState.initialState()
      : config = Config.empty(),
        deviceList = <DeviceModel>[],
        lightsStateCache = <String, bool>{};
}

class Config {
  final String ipAddress;
  final String username;
  bool isValid = false;

  Config(this.ipAddress, this.username, this.isValid);

  Config.empty() : this.username = 'Unknown', this.ipAddress = 'Unknown', this.isValid = false;
}
