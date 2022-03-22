import 'dart:convert';

import '../models/light_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lit/models/lights_list_model.dart';
import 'package:rxdart/rxdart.dart';

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
}