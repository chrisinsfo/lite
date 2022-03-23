import 'package:flutter/material.dart';
import 'package:lit/providers/config_provider.dart';
import 'package:provider/provider.dart';

class ConfigurationScreen extends StatefulWidget {
  static const routeName = 'config_screen';

  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context);

    onIPSaved(value) {
      configProvider.setIP(value);
    }

    onUsernameSaved(value) {
      configProvider.setUsername(value);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuration'),
      ),
      body: Column(
        children: [
          Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('IP Address', textAlign: TextAlign.left),
                TextFormField(
                  onSaved: onIPSaved,
                  maxLines: 1,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: configProvider.ipAddress),
                ),
                const Text('Username', textAlign: TextAlign.left),
                TextFormField(
                  onSaved: onUsernameSaved,
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(), hintText: configProvider.username),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          if (_globalKey.currentState!.validate()) {
                            _globalKey.currentState!.save();
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
