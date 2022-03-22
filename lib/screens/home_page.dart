import 'package:flutter/material.dart';
import 'package:lit/screens/lights_state_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      title: Text('Lit'),
    );

    return Scaffold(
      appBar: appBar,
      body:  SingleChildScrollView(
          child: Container(
            child:
              LightsStateWidget()
          ),
        ),
    );
  }
}