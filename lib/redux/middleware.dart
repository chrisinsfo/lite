import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lite/models/model.dart';
import 'package:lite/models/device_model.dart';
import 'package:lite/redux/actions.dart';
import 'package:redux/redux.dart';

void deviceApiMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {

  void getDevices() async {
    List<DeviceModel> deviceList;
    final GetDevicesAction a = action;
    final ip = a.config.ipAddress;
    final applicationKey = a.config.username;

    final Uri uri = Uri.parse('https://$ip/clip/v2/resource/device');

    final Map<String, String> headers = { 'hue-application-key' : applicationKey };

    late var response;

    try {
      response = await http.get(uri, headers: headers);
    } catch(error) {
      print(error);
    }

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      deviceList = DeviceModel.deserialize(decoded['data']);
      store.dispatch(FetchedDevicesAction(deviceList));
    } else {
      // TODO: follow API guidelines for error handling
      final errors = jsonDecode(response.body);
      throw(errors['errors']);
    }
  }

  if (action is GetDevicesAction) {
    getDevices();
  }

  next(action);
}

void lightsApiMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {

  void getLightsState() async {
    final Map<String, bool> lightsStateCache = <String, bool>{};
    final ip = store.state.config.ipAddress;
    final applicationKey = store.state.config.username;

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
      store.dispatch(FetchedLightsStateAction(lightsStateCache));
    } else {
      // TODO: follow API guidelines for error handling
      final errors = jsonDecode(response.body);
      throw(errors['errors']);
    }
  }

  void toggleLight(String lightId) async {
    final ip = store.state.config.ipAddress;
    final applicationKey = store.state.config.username;
    var lightsStateCache = store.state.lightsStateCache;
    final state = lightsStateCache[lightId] ?? false;
    final newState = !state;

    final Uri uri = Uri.parse('https://$ip/clip/v2/resource/light/$lightId');
    var body = json.encode({
      "on": {"on" : newState}
    });

    final Map<String, String> headers = { 'hue-application-key' : applicationKey };

    late var response;

    try {
      response = await http.put(uri, body: body, headers: headers);
    } catch (error) {
      print(error);
    }

    if (response.statusCode == 200) {
      lightsStateCache[lightId] = newState;
      store.dispatch(UpdatedLightStateAction(lightsStateCache));
    } else {
      final errors = jsonDecode(response.body);
      throw(errors['errors']);
    }
  }

  if (action is GetLightsStateAction) {
    getLightsState();
  }

  if (action is ToggleLightAction) {
    ToggleLightAction a = action;
    toggleLight(a.lightId);
  }

  next(action);
}
