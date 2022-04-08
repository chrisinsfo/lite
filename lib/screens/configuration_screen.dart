import 'package:flutter/material.dart';
import 'package:lite/models/model.dart';

class ConfigurationScreen extends StatelessWidget {

  Function(Config) onSetConfig;
  Config config;

  ConfigurationScreen(this.config, this.onSetConfig);

  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    String ip = config.ipAddress;
    String username = config.username;

    onIPSaved(value) {
      ip = value.toString().isNotEmpty ? value : Config.empty().ipAddress;
    }

    onUsernameSaved(value) {
      username = value.toString().isNotEmpty ? value : Config.empty().username;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuration'),
        backgroundColor: Colors.black87,
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
                        border: OutlineInputBorder(),
                        hintText: config.ipAddress),
                  ),
                  const Text('Username', textAlign: TextAlign.left),
                  TextFormField(
                    onSaved: onUsernameSaved,
                    maxLines: 2,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: config.username),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          key: const ValueKey('cancelConfigButton'),
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                            key: const ValueKey('saveConfigButton'),
                            child: const Text('Save'),
                            onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                _globalKey.currentState!.save();
                                onSetConfig(Config(ip, username, false));
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
