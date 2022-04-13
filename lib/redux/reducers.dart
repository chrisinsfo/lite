import 'dart:developer' as developer;

import 'package:lite/models/model.dart';
import 'package:lite/redux/actions.dart';
import 'package:lite/redux/selectors.dart';

// called every time we want to commit a change to store
AppState appStateReducer(AppState state, action) {
  switch (action.toString()) {

    case 'SetConfigAction':
      developer.log('reducer: SetConfigAction');
      SetConfigAction a = action;
      final isValid = isValidConfig(a.config);

      return AppState(
          isValid ? ApplicationState.validConfig : ApplicationState.invalidConfig,
          Config(
              a.config.ipAddress,
              a.config.username,
              isValid),
          state.deviceList,
          state.lightsStateCache
      );

    case 'GetDevicesAction':
      developer.log('reducer: GetDevicesAction');
      // middleware will intercept GetDevicesAction and trigger async call to devices api
      return AppState(ApplicationState.fetchingDevices, state.config, state.deviceList, state.lightsStateCache);

    case 'FetchedDevicesAction':
      developer.log('reducer: FetchedDevicesAction');
      final FetchedDevicesAction a = action;
      return AppState(ApplicationState.fetchedDevices, state.config, a.deviceList, state.lightsStateCache);

    case 'GetLightsStateAction':
      developer.log('reducer: GetLightsStateAction');
      final GetLightsStateAction a = action;
      return AppState(ApplicationState.fetchingLightsState, state.config, state.deviceList, state.lightsStateCache);

    case 'FetchedLightsStateAction':
      developer.log('reducer: FetchedLightsStateAction');
      final FetchedLightsStateAction a = action;
      return AppState(ApplicationState.fetchedLightsState, state.config, state.deviceList, a.lightsStateCache);

    case 'UpdatedLightStateAction':
      developer.log('reducer: UpdatedLightStateAction');
      final UpdatedLightStateAction a = action;
      return AppState(ApplicationState.userInteractive, state.config, state.deviceList, a.lightsStateCache);
  }

  return state;
}
