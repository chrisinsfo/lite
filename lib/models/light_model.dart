/*
 * Copyright © Chris Wardell, 2022.
 */

import 'package:flutter/foundation.dart';
import '../models/state_model.dart';

class LightModel {
  LightModel(this.id, this.name, this.state);

  @required final String id;
  @required final String name;
  @required final StateModel state;

  factory LightModel.fromJson(String id, Map<String, dynamic> json) {
    return LightModel(
        id,
        json['name'],
        StateModel.fromJson(json['state'])
    );
  }
}