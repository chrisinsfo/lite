import 'package:lite/models/device_model.dart';

enum ApplicationState {
  initialState,
  emptyConfig,
  invalidConfig,
  validConfig,
  fetchingDevices,
  fetchedDevices,
  fetchingLightsState,
  fetchedLightsState,
  userInteractive
}

// represent whole app state
class AppState {
  ApplicationState applicationState;

  final Config config;
  final List<DeviceModel> deviceList;
  // can be evolved to handle more complex state
  final Map<String, bool> lightsStateCache;

  AppState(this.applicationState, this.config, this.deviceList, this.lightsStateCache);

  AppState.initialState()
      : applicationState = ApplicationState.initialState,
        config = Config.empty(),
        deviceList = <DeviceModel>[],
        lightsStateCache = <String, bool>{};
}

class Config {
  final String ipAddress;
  final String username;
  bool isValid = false;

  Config(this.ipAddress, this.username, this.isValid);

  Config.empty()
      : this.username = 'Unknown',
        this.ipAddress = 'Unknown',
        this.isValid = false;
}
