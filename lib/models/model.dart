import 'package:flutter/foundation.dart';

// represent app state
class AppState {
  final Config config;

  AppState(@required this.config);

  AppState.initialState() : this.config = Config.empty();
}

class Config {
  Config(this.ipAddress, this.username);
  final String ipAddress;
  final String username;

  Config.empty() : this.username = 'Unknown', this.ipAddress = 'Unknown';
}
