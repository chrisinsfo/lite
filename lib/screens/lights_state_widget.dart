/*
 * Copyright © Chris Wardell, 2022.
 */

import 'package:flutter/material.dart';
import 'package:lit/models/light_model.dart';
import 'package:lit/providers/config_provider.dart';
import 'package:lit/screens/light_switch_widget.dart';
import 'package:provider/provider.dart';
import 'package:lit/blocs/lights_bloc.dart';

class LightsStateWidget extends StatefulWidget {
  @override
  _LightsStateWidgetState createState() => _LightsStateWidgetState();
}

class _LightsStateWidgetState extends State<LightsStateWidget> {
  @override
  Widget build(BuildContext context) {
    final lights = Provider.of<LightsBloc>(context, listen: true);
    final config = Provider.of<ConfigProvider>(context, listen: true);
    if (config.isValidConfig()) {
      print('lightStream called');
      lights.getLightStream(context);
    } else {
      return Text('Please update configuration');
    }

    return Column(
      children: [
        Row(
          children: const [
            Text("id",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(width: 16.0),
            Text("Name",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Spacer(),
            Text("State",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height - 100.0,
          child: StreamBuilder(
            stream: lights.lightStream,
            builder: (ctx, snapshot) {
              if (snapshot.hasError) {
                print('error.log: ${snapshot.error.toString()}');
              }
              if (!snapshot.hasData) {
                return Text("No Data");
              }
              if (snapshot.hasData) {
                List<LightModel> lights = snapshot.data as List<LightModel>;
                if (lights.length == 0) {
                  return Text("No lights to show");
                }
                ;
                List<LightSwitchWidget> lightList = List.empty(growable: true);
                for (var light in lights) {
                  lightList.add(LightSwitchWidget(light));
                }
                return Container(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: lightList,
                  ),
                );
              }
              return const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
