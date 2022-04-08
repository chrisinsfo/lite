import 'package:flutter/foundation.dart';

// represent whole app state
class AppState {
  final Config config;

  AppState(this.config);

  AppState.initialState() : this.config = Config.empty();
}

class Config {
  final String ipAddress;
  final String username;
  bool isValid = false;

  Config(this.ipAddress, this.username, this.isValid);

  Config.empty() : this.username = 'Unknown', this.ipAddress = 'Unknown', this.isValid = false;
}
