/*
 * Copyright © Chris Wardell, 2022.
 */

import 'package:flutter/material.dart';
import 'package:lite/blocs/device_bloc.dart';
import 'package:lite/models/device_model.dart';
import 'package:lite/util/app_bar_dimension.dart';
import 'package:lite/widgets/device_list_tile.dart';
import 'package:lite/providers/config_provider.dart';
import 'package:lite/screens/configuration_screen.dart';
import 'package:lite/util/environment_utility.dart';

import 'package:provider/provider.dart';

class DeviceListScreen extends StatefulWidget {
  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  final _getMock = false;
  @override
  Widget build(BuildContext context) {
    final devices = Provider.of<DeviceBloc>(context, listen: false);
    final config = Provider.of<ConfigProvider>(context, listen: true);
    final appBarDimension = context.dependOnInheritedWidgetOfExactType<AppBarDimension>()!;

    if (EnvironmentUtility.environment() == Environment.DEVELOPMENT && _getMock == true) {
      devices.mockDeviceStream();
    } else {
      if (config.isValidConfig() && _getMock == false) {
        devices.getDeviceStream(context);
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Please update configuration with your bridge information.', style: TextStyle(fontSize: 24.0, color: Colors.white), textAlign: TextAlign.center,),
              ElevatedButton(
                  child: const Text('OK'), onPressed: () => Navigator.pushNamed(context, ConfigurationScreen.routeName)),
            ],
          ),
        );
      }
    }

    return Column(
      children: [
        Row(
          children: const [
            Text("LIGHTS", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height - appBarDimension.height - AppBarDimension.statusBarHeight - 60.0,
          child: StreamBuilder(
            stream: devices.deviceStream,
            builder: (ctx, snapshot) {
              if (snapshot.hasError) {
                print('error.log: ${snapshot.error.toString()}');
              }
              if (!snapshot.hasData) {
                return Text("No Data", style: TextStyle(color: Colors.white));
              }
              if (snapshot.hasData) {
                List<DeviceModel> devices = snapshot.data as List<DeviceModel>;
                if (devices.length == 0) {
                  return Text("No devices to show", style: TextStyle(color: Colors.white));
                }
                List<DeviceListTile> deviceTiles = devices.map((e) => DeviceListTile(e)).toList();
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: deviceTiles,
                );
              }
              return const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


