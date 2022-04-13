import 'package:flutter_test/flutter_test.dart';
import 'package:lite/models/device_model.dart';
import 'package:lite/models/model.dart';
import 'package:lite/redux/actions.dart';
import 'package:lite/redux/reducers.dart';
import 'package:mockito/mockito.dart';
import 'package:lite/redux/middleware.mocks.dart';
import 'package:redux/redux.dart';

void main() {
  group('test getDevices middleware', () {
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
      when(mock.getDevices(store))
          .thenAnswer((_) async => store.dispatch(FetchedDevicesAction(deviceList))
      );

      store.dispatch(mock.getDevices(store));

      expect(store.state.applicationState, ApplicationState.fetchedDevices);
      expect(store.state.deviceList, deviceList);
    });

  });
}
