import 'package:lite/models/model.dart';
import 'package:lite/redux/actions.dart';

// called every time we want to commit a change to store
AppState appStateReducer(AppState state, action) {
  if (action is SetConfigAction) {
    SetConfigAction a = action;
    return AppState(a.config);
  } else {
    return state;
  }
}
