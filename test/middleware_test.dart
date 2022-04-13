import 'package:flutter_test/flutter_test.dart';
import 'package:lite/models/device_model.dart';
import 'package:lite/models/model.dart';
import 'package:lite/redux/actions.dart';
import 'package:lite/redux/reducers.dart';
import 'package:mockito/mockito.dart';
import 'package:lite/redux/middleware.mocks.dart';
import 'package:redux/redux.dart';

void main() {
  group('test DevicesApi middleware', () {
    test('Should get devices when store.getDevices called and update application state', () {
      final deviceList = <DeviceModel>[
        DeviceModel('1234', Metadata('spot_bulb', 'LR1'),
            <Service>[Service("1234", "light")])
      ];

      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      final mock = MockDeviceApi();
      when(mock.getDevices(store)).thenAnswer(
              (_) async => store.dispatch(FetchedDevicesAction(deviceList)));

      store.dispatch(mock.getDevices(store));

      expect(store.state.applicationState, ApplicationState.fetchedDevices);
      expect(store.state.deviceList, deviceList);
    });
  });

  group('test LightsApi middleware', () {
    test('Should get lights status when getLightsState called, and update application state', () {
      final Map<String, bool> lightsState = <String, bool>{'12345': false};

      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      final mock = MockLightsApi();
      when(mock.getLightsState(store)).thenAnswer(
              (_) async => store.dispatch(FetchedLightsStateAction(lightsState)));

      store.dispatch(mock.getLightsState(store));

      expect(store.state.applicationState, ApplicationState.fetchedLightsState);
      expect(store.state.lightsStateCache, lightsState);
    });

    test('Should update application state when light toggled', () {
      final Map<String, bool> lightsState = <String, bool>{'12345': true};

      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      final mock = MockLightsApi();
      when(mock.toggleLight(store, '12345')).thenAnswer(
              (_) async => store.dispatch(UpdatedLightStateAction(lightsState)));

      store.dispatch(mock.toggleLight(store, '12345'));

      expect(store.state.applicationState, ApplicationState.userInteractive);
      expect(store.state.lightsStateCache['12345'], true);
    });
  });
}
