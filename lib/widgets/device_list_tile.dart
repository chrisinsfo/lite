import 'package:flutter/material.dart';
import 'package:lite/models/device_model.dart';

class DeviceListTile extends StatelessWidget {
  const DeviceListTile(this.deviceModel);
  final DeviceModel deviceModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.network_wifi, color: Colors.yellow),
      title: Text(deviceModel.metadata.name, style: const TextStyle(color: Colors.white)),
      subtitle: Text(deviceModel.metadata.archetype, style: const TextStyle(color: Colors.white70)),
      trailing: const Switch(value: false, onChanged: null),
    );
  }
}
