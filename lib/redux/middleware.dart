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
