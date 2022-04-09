import 'package:lite/models/model.dart';
import 'package:lite/redux/actions.dart';
import 'package:lite/redux/selectors.dart';

// called every time we want to commit a change to store
AppState appStateReducer(AppState state, action) {

  if (action is WillSetConfigAction) {
    WillSetConfigAction a = action;
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
  }

  if (action is GetDevicesAction) {
    // middleware will intercept GetDevicesAction and trigger async call to devices api
    return AppState(ApplicationState.fetchingDevices, state.config, state.deviceList, state.lightsStateCache);
  }

  if (action is FetchedDevicesAction) {
    final FetchedDevicesAction a = action;
    return AppState(ApplicationState.fetchedDevices, state.config, a.deviceList, state.lightsStateCache);
  }

  if (action is GetLightsStateAction) {
    final GetLightsStateAction a = action;
    return AppState(ApplicationState.fetchingLightsState, state.config, state.deviceList, state.lightsStateCache);
  }

  if (action is FetchedLightsStateAction) {
    final FetchedLightsStateAction a = action;
    return AppState(ApplicationState.fetchedLightsState, state.config, state.deviceList, a.lightsStateCache);
  }

  if (action is ToggleLightAction) {
    return AppState(ApplicationState.userInteractive, state.config, state.deviceList, state.lightsStateCache);
  }

  if (action is UpdatedLightStateAction) {
    final UpdatedLightStateAction a = action;
    return AppState(ApplicationState.userInteractive, state.config, state.deviceList, a.lightsStateCache);
  }

  return state;
}
