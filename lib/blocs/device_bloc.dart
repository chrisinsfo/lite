import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:lite/models/device_model.dart';
import 'package:lite/providers/config_provider.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class DeviceBloc {
  PublishSubject<List<DeviceModel>> deviceStream = PublishSubject<List<DeviceModel>>();
  final Map<String, bool> lightsStateCache = Map<String, bool>();

  void mockDeviceStream() async {
    Future<String> getJson() async {
      return await rootBundle.loadString('lib/assets/device.json');
    }

    var json = await getJson();
    Map<String, dynamic> data = jsonDecode(json);
    final list = DeviceModel.deserialize(data['data']);
    deviceStream.add(list);
  }

  void toggleLight(BuildContext context, String lightId, bool state) async {
    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    final ip = configProvider.ipAddress;
    final applicationKey = configProvider.username;
    final Uri uri = Uri.parse('https://$ip/clip/v2/resource/light/$lightId');
    var body = json.encode({
      "on": {"on" : state}
    });

    final Map<String, String> headers = { 'hue-application-key' : applicationKey };

    try {
      await http.put(uri, body: body, headers: headers);
      lightsStateCache[lightId] = state;
    } catch (error) {
      throw(error);
    }
  }

  void getLightsState(BuildContext context) async {
    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    final ip = configProvider.ipAddress;
    final applicationKey = configProvider.username;

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

  void getDeviceStream(BuildContext context) async {
    getLightsState(context);

    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    final ip = configProvider.ipAddress;
    final applicationKey = configProvider.username;

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
      final devices = DeviceModel.deserialize(decoded['data']);
      deviceStream.add(devices);
    } else {
      // TODO: follow API guidelines for error handling
      final errors = jsonDecode(response.body);
      throw(errors['errors']);
    }
  }

}
