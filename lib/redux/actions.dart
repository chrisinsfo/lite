import 'package:lite/models/model.dart';

class SetConfigAction {
  final Config config;

  SetConfigAction(this.config);
}

class ValidateConfigAction {
  bool isValidConfig(Config config) {
    return config.ipAddress.isNotEmpty
        && !(config.ipAddress == 'Unknown')
        && config.username.isNotEmpty
        && !(config.username == 'Unknown');
  }
}
