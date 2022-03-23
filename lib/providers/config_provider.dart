import 'package:flutter/foundation.dart';

class ConfigProvider with ChangeNotifier {
  String ipAddress = 'Unknown';
  String username = 'Unknown';

  void setIP(String ipAddress) {
    this.ipAddress = ipAddress;
    notifyListeners();
  }

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  bool isValidConfig() {
    return ipAddress.isNotEmpty && !(ipAddress == 'Unknown') && username.isNotEmpty && !(username == 'Unknown');
  }
}
