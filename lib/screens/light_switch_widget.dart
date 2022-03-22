import 'package:flutter/material.dart';
import 'package:lit/models/light_model.dart';
import 'package:lit/util/color_palette_utility.dart';

class LightSwitchWidget extends StatelessWidget {
  LightModel lightModel ;
  LightSwitchWidget(this.lightModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  lightModel.state.on ? Theme.of(context).cardColor : ColorPaletteUtility.white,
      child:
        Row(children: [
          Text(lightModel.id),
          const SizedBox(width: 20),
          Text(lightModel.name),
          Spacer(),
          lightModel.state.on ?
            Switch(value: lightModel.state.on, onChanged: null, trackColor: MaterialStateProperty.all(ColorPaletteUtility.green)) :
            Switch(value: lightModel.state.on, onChanged: null, trackColor: MaterialStateProperty.all(ColorPaletteUtility.orange))
        ],),
    );
  }
}