import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lite/models/model.dart';
import 'package:lite/redux/middleware.dart';
import 'package:lite/models/device_model.dart';
import 'package:lite/screens/device_list_screen.dart';
import 'package:redux/redux.dart';

class DevicesContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      // convert the store into a viewModel
      // the resulting viewModel will be passed into the builder function
        converter: _ViewModel.fromStore,
        builder: (context, vm) =>
            DeviceListScreen(vm.deviceList, vm.config, vm.lightsStateCache, vm.onToggle)
    );
  }
}

class _ViewModel {
  List<DeviceModel> deviceList;
  Config config;
  Map<String, bool> lightsStateCache;
  Function(String) onToggle;

  _ViewModel(this.deviceList, this.config, this.lightsStateCache, this.onToggle);

  static _ViewModel fromStore(Store<AppState> store) {
    if (store.state.applicationState == ApplicationState.validConfig) {
      store.dispatch(DeviceApi().getDevices);
    }

    if (store.state.applicationState == ApplicationState.fetchedDevices) {
      store.dispatch(getLightsState);
    }

    return _ViewModel(
        store.state.deviceList,
        store.state.config,
        store.state.lightsStateCache,
        (lightId) => store.dispatch(toggleLight(store, lightId)));
  }
}
