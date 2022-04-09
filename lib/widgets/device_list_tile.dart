import 'package:flutter/material.dart';
import 'package:lite/models/device_model.dart';

class DeviceListTile extends StatefulWidget {
  final DeviceModel deviceModel;
  bool onState;
  Function(String) toggleOnState;

  DeviceListTile(this.deviceModel, this.onState, this.toggleOnState);

  @override
  State<DeviceListTile> createState() => _DeviceListTileState();
}

class _DeviceListTileState extends State<DeviceListTile> {
  //TODO: local state
  
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.black12,
        child: ListTile(
          leading: const Icon(Icons.network_wifi, color: Colors.yellow),
          title: Text(widget.deviceModel.metadata.name, style: const TextStyle(color: Colors.white)),
          subtitle: Text(widget.deviceModel.metadata.archetype.replaceAll('_', ' '), style: const TextStyle(color: Colors.white70)),
          trailing: widget.onState
              ? Switch(
              value: widget.onState,
              onChanged: (bool newValue) {
                setState(() {
                  widget.onState = newValue;
                  widget.toggleOnState(widget.deviceModel.services.first.rid);
                });
              },
              trackColor: MaterialStateProperty.all(Colors.green))
              : Switch(
              value: widget.onState,
              onChanged: (bool newValue) {
                setState(() {
                  widget.onState = newValue;
                  widget.toggleOnState(widget.deviceModel.services.first.rid);
                });
              },
              trackColor: MaterialStateProperty.all(Colors.orange)
          ),
        ),
      );
  }
}
