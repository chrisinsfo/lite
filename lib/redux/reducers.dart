import 'package:lite/models/model.dart';
import 'package:lite/redux/actions.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(Config.empty());
}

Config configReducer(Config config, dynamic action) {
  if (action == SetConfigAction)  {
    return config;
  }
  return config;
}
