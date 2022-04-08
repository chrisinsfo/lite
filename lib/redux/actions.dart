import 'dart:convert';

import 'package:lite/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:lite/models/device_model.dart';

class SetConfigAction {
  final Config config;

  SetConfigAction(this.config);
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
  final Map<String, bool> lightsStateCache = Map<String, bool>();

  final Config _config;
  GetLightsStateAction(this._config);

    Future getLightsState() async {
      final ip = _config.ipAddress;
      final applicationKey = _config.username;

      final Uri uri = Uri.parse('https://$ip/clip/v2/resource/light');

      final Map<String, String> headers = { 'hue-application-key' : applicationKey };

      late var response;

      try {
        response = await http.get(uri, headers: headers);
      } catch(error) {
        print(error);
      }

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final lights = decoded['data'];
        for(var light in lights) {
          lightsStateCache[light['owner']['rid']] = light['on']['on'];
        }

      } else {
        // TODO: follow API guidelines for error handling
        final errors = jsonDecode(response.body);
        throw(errors['errors']);
      }
    }
}

class GetDevicesAction {
  final Config config;
  List<DeviceModel> deviceList;

  GetDevicesAction(this.config, this.deviceList);

}

class FetchedDevicesAction {
  final Config config;
  List<DeviceModel> deviceList;

  FetchedDevicesAction(this.config, this.deviceList);
}