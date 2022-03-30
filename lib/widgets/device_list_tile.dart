import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:lite/blocs/device_bloc.dart';
import 'package:lite/models/device_model.dart';
import 'package:lite/models/model.dart';
import 'package:provider/provider.dart';

class DeviceListTile extends StatefulWidget {
  const DeviceListTile(this.deviceModel);
  final DeviceModel deviceModel;

  @override
  State<DeviceListTile> createState() => _DeviceListTileState();
}

class _DeviceListTileState extends State<DeviceListTile> {
  var onState = false;

  @override
  void initState() {
    final devices = Provider.of<DeviceBloc>(context, listen: false);
    onState = devices.lightsStateCache[widget.deviceModel.id] ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceBloc = Provider.of<DeviceBloc>(context, listen: false);
    return StoreConnector<AppState, Config>(
      converter: (Store<AppState> store) => store.state.config,
      builder: (context, config) => Card(
        color: Colors.black12,
        child: ListTile(
          leading: const Icon(Icons.network_wifi, color: Colors.yellow),
          title: Text(widget.deviceModel.metadata.name, style: const TextStyle(color: Colors.white)),
          subtitle: Text(widget.deviceModel.metadata.archetype.replaceAll('_', ' '), style: const TextStyle(color: Colors.white70)),
          trailing: onState
              ? Switch(
              value: onState,
              onChanged: (bool newValue) {
                setState(() {
                  onState = newValue;

                  deviceBloc.toggleLight(context, config, widget.deviceModel.services.first.rid, onState);
                });
              },
              trackColor: MaterialStateProperty.all(Colors.green))
              : Switch(
              value: onState,
              onChanged: (bool newValue) {
                setState(() {
                  onState = newValue;
                  deviceBloc.toggleLight(context, config, widget.deviceModel.services.first.rid, onState);
                });
              },
              trackColor: MaterialStateProperty.all(Colors.orange)
          ),
        ),
      ),
    );
  }
}
