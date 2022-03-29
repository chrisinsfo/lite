import 'package:flutter/material.dart';
import 'package:lite/blocs/device_bloc.dart';
import 'package:lite/models/device_model.dart';
import 'package:provider/provider.dart';

class DeviceListTile extends StatelessWidget {
  const DeviceListTile(this.deviceModel);
  final DeviceModel deviceModel;

  @override
  Widget build(BuildContext context) {
    final devices = Provider.of<DeviceBloc>(context, listen: false);
    final bool onState = devices.lightsStateCache[deviceModel.id] ?? false;

    return Card(
      color: Colors.black12,
      child: ListTile(
        leading: const Icon(Icons.network_wifi, color: Colors.yellow),
        title: Text(deviceModel.metadata.name, style: const TextStyle(color: Colors.white)),
        subtitle: Text(deviceModel.metadata.archetype, style: const TextStyle(color: Colors.white70)),
        //TODO: implement onChanged
        trailing: Switch(
            value: onState,
            onChanged: null,
            trackColor: onState == true ? MaterialStateProperty.all(Colors.green) : MaterialStateProperty.all(Colors.orange),
        ),
      ),
    );
  }
}
