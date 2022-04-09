import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lite/models/model.dart';
import 'package:lite/redux/actions.dart';
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
            DeviceListScreen(vm.deviceList, vm.config, vm.lightsStateCache)
    );
  }
}

class _ViewModel {
  List<DeviceModel> deviceList;
  Config config;
  Map<String, bool> lightsStateCache;

  _ViewModel(this.deviceList, this.config, this.lightsStateCache);

  static _ViewModel fromStore(Store<AppState> store) {
    if (store.state.applicationState == ApplicationState.validConfig) {
      store.dispatch(GetDevicesAction(store.state.config, store.state.deviceList));
    }

    if (store.state.applicationState == ApplicationState.fetchedDevices) {
      store.dispatch(GetLightsStateAction(store.state.lightsStateCache));
    }

    return _ViewModel(store.state.deviceList, store.state.config, store.state.lightsStateCache);
  }
}
