import 'package:flutter/foundation.dart';
/*
"state": {
      "on": false,
      "bri": 254,
      "hue": 12518,
      "sat": 226,
      "effect": "none",
      "xy": [
        0.5267,
        0.4133
      ],
      "ct": 500,
      "alert": "select",
      "colormode": "ct",
      "mode": "homeautomation",
      "reachable": true
    }
 */

class StateModel {

  StateModel(this.on, this.bri, this.hue, this.sat, this.effect, this.mode, this.reachable);

  @required final bool on;
  @required final int bri;
  @required final int hue;
  @required final int sat;
  @required final String effect;
  @required final String mode;
  @required final bool reachable;

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
        json['on'] ?? false,
        json['bri'] ?? 0,
        json['hue'] ?? 0,
        json['sat'] ?? 0,
        json['effect'] ?? 'none',
        json['mode'] ?? 'homeautomation',
        json['reachable'] ?? false
    );
  }
}
