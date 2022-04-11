import 'package:flutter_test/flutter_test.dart';
import 'package:lite/models/device_model.dart';
import 'package:lite/models/model.dart';
import 'package:redux/redux.dart';
import 'package:lite/redux/reducers.dart';
import 'package:lite/redux/actions.dart';

void main() {
  group('State Reducer', () {
    test('should update store config to valid with valid inputs', () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      store
          .dispatch(SetConfigAction(Config('123.456.78.9', 'Mark', false)));

      expect(store.state.config.isValid, true);
      expect(store.state.config.username, 'Mark');
      expect(store.state.config.ipAddress, '123.456.78.9');
    });

    test('should not update store config to valid with invalid inputs', () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      store.dispatch(SetConfigAction(Config('Unknown', 'Mark', false)));

      expect(store.state.config.isValid, false);
    });

    test('GetDevicesAction should update applicationState to ApplicationState.fetchingDevices', () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      store.dispatch(GetDevicesAction(DeviceModel.copyWith(store.state.deviceList)));

      expect(store.state.applicationState, ApplicationState.fetchingDevices);
    });

    test('FetchedDevicesAction should update applicationState to .fetchedDevices and update state device list', () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      final devices = <DeviceModel>[
        DeviceModel('1234', Metadata('spot_bulb', 'LR1'),
            <Service>[Service("1234", "light")])
      ];

      store.dispatch(FetchedDevicesAction(devices));

      expect(store.state.applicationState, ApplicationState.fetchedDevices);
      expect(store.state.deviceList, devices);
    });

    test('GetLightsStateAction should update applicationState to ApplicationState.fetchingLightsState', () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      store.dispatch(GetLightsStateAction(store.state.lightsStateCache));

      expect(store.state.applicationState, ApplicationState.fetchingLightsState);
    });

    test('FetchedLightsStateAction should update applicationState to ApplicationState.fetchedLightsState '
        'and update state.lightsStateCache' , () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      final lightsStateCache = {'12345': false};

      store.dispatch(FetchedLightsStateAction(lightsStateCache));

      expect(store.state.applicationState, ApplicationState.fetchedLightsState);
      expect(store.state.lightsStateCache, lightsStateCache);
    });

  });
}
