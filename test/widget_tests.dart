import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lite/models/model.dart';
import 'package:lite/screens/configuration_screen.dart';

  void main() {
    // Define a test. The TestWidgets function also provides a WidgetTester
    // to work with. The WidgetTester allows you to build and interact
    // with widgets in the test environment.
    testWidgets('ConfigurationScreen has expected widgets and text', (WidgetTester tester) async {
      String ip = '123.456.789';
      String username = 'hue_user';
      final Config config = Config(ip, username);

      Function onTap (Config config) => (config) {};

      await tester.pumpWidget(
        MaterialApp(home: ConfigurationScreen(config, onTap))
      );

      final ipAddressTitleFinder = find.text('IP Address');
      final usernameTitleFinder = find.text('Username');
      final ipAddressFinder = find.text(ip);
      final usernameFinder = find.text(username);
      final setButtonFinder = find.byKey(const ValueKey('saveConfigButton'));
      final cancelButtonFinder = find.byKey(const ValueKey('cancelConfigButton'));

      expect(ipAddressTitleFinder, findsOneWidget);
      expect(usernameTitleFinder, findsOneWidget);
      expect(ipAddressFinder, findsOneWidget);
      expect(usernameFinder, findsOneWidget);
      expect(setButtonFinder, findsOneWidget);
      expect(cancelButtonFinder, findsOneWidget);
    });
  }
