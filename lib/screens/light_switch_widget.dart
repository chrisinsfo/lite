import 'package:flutter/material.dart';
import 'package:lit/blocs/lights_bloc.dart';
import 'package:lit/models/light_model.dart';
import 'package:lit/util/color_palette_utility.dart';
import 'package:provider/provider.dart';

class LightSwitchWidget extends StatefulWidget {
  LightModel lightModel;
  LightSwitchWidget(this.lightModel);

  @override
  State<LightSwitchWidget> createState() => _LightSwitchWidgetState();
}

class _LightSwitchWidgetState extends State<LightSwitchWidget> {
  var onState = false;

  @override
  void initState() {
    onState = widget.lightModel.state.on;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void toggle(bool onState) {
      final lightsBloc = Provider.of<LightsBloc>(context, listen: false);
      lightsBloc.toggleLight(
          context, widget.lightModel.id, widget.lightModel.state.on);
    }

    return Card(
      color: widget.lightModel.state.on
          ? Theme.of(context).cardColor
          : ColorPaletteUtility.white,
      child: Row(
        children: [
          Text(widget.lightModel.id),
          const SizedBox(width: 20),
          Text(widget.lightModel.name),
          Spacer(),
          widget.lightModel.state.on
              ? Switch(
                  value: onState,
                  onChanged: (bool newValue) {
                    setState(() {
                      // toggle local switch state
                      onState = !widget.lightModel.state.on;
                      toggle(widget.lightModel.state.on);
                    });
                  },
                  trackColor: MaterialStateProperty.all(ColorPaletteUtility.green))
              : Switch(
                  value: onState,
                  onChanged: (bool newValue) {
                    setState(() {
                      onState = !widget.lightModel.state.on;
                      toggle(widget.lightModel.state.on);
                    });
                  },
                  trackColor: MaterialStateProperty.all(ColorPaletteUtility.orange))
        ],
      ),
    );
  }
}
