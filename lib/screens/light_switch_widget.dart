import 'package:flutter/material.dart';
import 'package:lit/models/light_model.dart';

class LightSwitchWidget extends StatelessWidget {
  LightModel lightModel ;
  LightSwitchWidget(this.lightModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Text(lightModel.id),
          Spacer(),
          Text(lightModel.name),
          Spacer(),
          Text(lightModel.state.on ? "ON" : "OFF"),
        ],)
      ],
    );
  }
}