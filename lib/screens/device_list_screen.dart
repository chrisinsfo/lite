/*
 * Copyright © Chris Wardell, 2022.
 */

import 'package:flutter/material.dart';
import 'package:lite/models/device_model.dart';
import 'package:lite/models/model.dart';
import 'package:lite/util/app_bar_dimension.dart';
import 'package:lite/widgets/device_list_tile.dart';
import 'package:lite/containers/config_container.dart';

class DeviceListScreen extends StatelessWidget {
  final List<DeviceModel> deviceList;
  final Config config;
  final Map<String, bool> lightsStateCache;

  DeviceListScreen(this.deviceList, this.config, this.lightsStateCache);

  @override
  Widget build(BuildContext context) {
    final appBarDimension =
        context.dependOnInheritedWidgetOfExactType<AppBarDimension>()!;

    return config.isValid
        ? Column(
            children: [
              Row(
                children: const [
                  Text("LIGHTS",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    appBarDimension.height -
                    AppBarDimension.statusBarHeight -
                    60.0,
                child: ListView.builder(
                  itemCount: deviceList.length,
                  itemBuilder: (ctx, index) {
                    if (deviceList.isEmpty) {
                      return Text("No devices to show",
                          style: TextStyle(color: Colors.white));
                    } else {
                      final model = deviceList[index];
                      //TODO: pass store.dispatch(ToggleLightAction)
                      return DeviceListTile(model, lightsStateCache[model.id] ?? false, (bool) => bool );
                    }
                  },
                ),
              ),
            ],
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Please update configuration with your bridge information.',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pushNamed(
                        context, ConfigContainer.routeName)),
              ],
            ),
          );
  }
}
