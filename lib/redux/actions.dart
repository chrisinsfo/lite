import 'dart:convert';

import 'package:lite/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:lite/models/device_model.dart';

class WillSetConfigAction {
  final Config config;

  WillSetConfigAction(this.config);
}

class ToggleLightAction {
  final Config _config;
  final Map<String, bool> lightsStateCache;
  ToggleLightAction(this._config, this.lightsStateCache);

  Future toggleLight(String lightId) async {
    final ip = _config.ipAddress;
    final applicationKey = _config.username;
    var state = lightsStateCache[lightId];

    final Uri uri = Uri.parse('https://$ip/clip/v2/resource/light/$lightId');
    var body = json.encode({
      "on": {"on" : state}
    });

    final Map<String, String> headers = { 'hue-application-key' : applicationKey };

    try {
      await http.put(uri, body: body, headers: headers);
      if (state != null) {
        lightsStateCache[lightId] = state;
      }
    } catch (error) {
      print(error);
    }
  }
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