import '../models/light_model.dart';

class LightsListModel {

  static List<LightModel> deserialize(Map<String, dynamic> json) {
    final List<LightModel> lights = []..length = 0;

    for (var light in json.keys) {
      lights.add(LightModel.fromJson(light, json[light]));
    }
    return lights;
  }
}