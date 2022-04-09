import 'package:lite/models/model.dart';

bool isValidConfig(Config config) {
  return config.ipAddress.isNotEmpty
      && !(config.ipAddress == 'Unknown')
      && config.username.isNotEmpty
      && !(config.username == 'Unknown');
}
