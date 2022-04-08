import 'package:flutter_test/flutter_test.dart';
import 'package:lite/models/model.dart';
import 'package:redux/redux.dart';
import 'package:lite/redux/reducers.dart';
import 'package:lite/redux/actions.dart';

void main() {
  group('State Reducer', ()
  {
    test('should update store config to valid with valid inputs', () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      store.dispatch(SetConfigAction(Config('123.456.78.9', 'Mark', false)));

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

  });
}
