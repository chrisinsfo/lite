import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

import 'package:lit/models/light_model.dart';
import 'package:lit/models/lights_list_model.dart';
import 'package:lit/providers/config_provider.dart';

class LightsBloc with ChangeNotifier {

  PublishSubject<List<LightModel>> lightStream = PublishSubject<List<LightModel>>();

  void mockLightStream() async {
    Future<String> getJson() async {
      return await rootBundle.loadString('lib/assets/lights.json');
    }

    var data = await getJson();
    Map<String, dynamic> decoded = jsonDecode(data);
    final list = LightsListModel.deserialize(decoded);
    lightStream.add(list);
  }

  void getLightStream(BuildContext context) async {
    final configProvider = Provider.of<ConfigProvider>(context, listen: true);
    final ip = configProvider.ipAddress;
    final username = configProvider.username;

    final url = 'http://$ip/api/$username/lights';
    late var response;
    try {
      response = await http.get(Uri.parse(url));
    } catch (error) {
      lightStream.addError(error);
      return;
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = jsonDecode(response.body);
      final list = LightsListModel.deserialize(decoded);
      lightStream.add(list);
    } else {
      throw(response.body);
    }
  }

  // https://developers.meethue.com/develop/hue-api/lights-api/#set-light-state
  void toggleLight(BuildContext context, String lightId, bool state) async {
    final toggledState = !state;
    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    final ip = configProvider.ipAddress;
    final username = configProvider.username;
    final url = 'http://$ip/api/$username/lights/$lightId/state';
    var body = json.encode({
      "on": toggledState
    });

    try {
      await http.put(Uri.parse(url), body: body);
      notifyListeners();
    } catch (error) {
      throw(error);
    }
  }

}
