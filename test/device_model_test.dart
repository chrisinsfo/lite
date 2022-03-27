import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:lit/models/device_model.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<String> getJson() async {
    return await rootBundle.loadString('test/test_resources/device.json');
  }

  group('test i/o', () {

    test('deserialization', () async {
      var json = await getJson();
      Map<String, dynamic> data = jsonDecode(json);

      final list = DeviceModel.deserialize(data['data']);
      expect(list[0].metadata.name, 'LR 2');
      expect(list[0].metadata.archetype, 'spot_bulb');
      expect(list[0].services[0].rtype, 'light');
    });
  });

}
