import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lite/redux/actions.dart';
import 'package:redux/redux.dart';

import 'package:lite/models/model.dart';

class ConfigurationScreen extends StatelessWidget {
  static const routeName = 'config_screen';

  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    String ip = Config.empty().ipAddress;
    String username = Config.empty().username;

    onIPSaved(value) {
      ip = value.toString().isNotEmpty ? value : Config.empty().ipAddress;
    }

    onUsernameSaved(value) {
      username = value.toString().isNotEmpty ? value : Config.empty().username;;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuration'),
        backgroundColor: Colors.black87,
      ),
      body: StoreConnector<AppState, Config>(
        converter: (Store<AppState> store) => store.state.config,
        builder: (context, config) => Column(
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
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        StoreConnector<AppState, VoidCallback>(
                          converter: (store) { return () => store.dispatch(SetConfigAction(Config(ip, username))); },
                          builder: (context, callback) =>
                          ElevatedButton(
                            child: const Text('Save'),
                            onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                _globalKey.currentState!.save();
                                callback();
                              }
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
