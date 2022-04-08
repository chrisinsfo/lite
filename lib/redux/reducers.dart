import 'package:lite/models/model.dart';
import 'package:lite/redux/actions.dart';

// called every time we want to commit a change to store
AppState appStateReducer(AppState state, action) {

  if (action is SetConfigAction) {
    SetConfigAction a = action;
    return AppState(
        Config(
            a.config.ipAddress,
            a.config.username,
            a.config.ipAddress.isNotEmpty
                && !(a.config.ipAddress == 'Unknown')
                && a.config.username.isNotEmpty
                && !(a.config.username == 'Unknown'))
    );
  }
  return state;
}
