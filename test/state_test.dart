import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lit/models/state_model.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<String> getJson() async {
    return await rootBundle.loadString('test/test_resources/state.json');
  }

  group('test i/o', () {

    test('deserialization', () async {
      var data = await getJson();
      Map<String, dynamic> decoded = jsonDecode(data);
      final state = StateModel.fromJson(decoded['state']);
      expect(state.on, false);
      expect(state.bri, 254);
      expect(state.hue, 12518);
      expect(state.sat, 226);
      expect(state.effect, 'none');
      expect(state.mode, 'homeautomation');
      expect(state.reachable, true);
    });
  });

}