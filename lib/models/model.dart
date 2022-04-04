import 'package:flutter/foundation.dart';

// represent whole app state
class AppState {
  final Config config;

  AppState(@required this.config);

  AppState.initialState() : this.config = Config.empty();
}

class Config {
  final String ipAddress;
  final String username;

  Config(this.ipAddress, this.username);

  Config.empty() : this.username = 'Unknown', this.ipAddress = 'Unknown';
}
