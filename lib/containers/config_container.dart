import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lite/models/model.dart';
import 'package:lite/redux/actions.dart';
import 'package:lite/screens/configuration_screen.dart';
import 'package:redux/redux.dart';

class ConfigContainer extends StatelessWidget {
  static const routeName = 'config_container';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        // convert the store into a viewModel
        // the resulting viewModel will be passed into the builder function
        converter: _ViewModel.fromStore,
        builder: (context, vm) =>
            ConfigurationScreen(vm.config, vm.onSetConfig));
  }
}

class _ViewModel {
  final Config config;
  final Function(Config) onSetConfig;

  _ViewModel({required this.config, required this.onSetConfig});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        config: store.state.config,
        onSetConfig: (config) {
          store.dispatch(SetConfigAction(config));
        });
  }
}
