import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:lit/models/lights_list_model.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<String> getJson() async {
    return await rootBundle.loadString('test/test_resources/lights.json');
  }

  group('test i/o', () {

    test('deserialization', () async {
      var data = await getJson();
      Map<String, dynamic> decoded = jsonDecode(data);
      final list = LightsListModel.deserialize(decoded);
      expect(list[0].name, 'LR 6');
      expect(list[0].state.on, false);
    });
  });

}