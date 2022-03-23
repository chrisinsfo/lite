import 'package:flutter/material.dart';
import 'package:lit/screens/configuration_screen.dart';
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
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.network_wifi),
            onPressed: () =>
                Navigator.pushNamed(context, ConfigurationScreen.routeName)),
      ],
      backgroundColor: Colors.black87,
      title: Align(
          alignment: Alignment.topLeft,
          child: Text('Lit', textAlign: TextAlign.left, style: TextStyle(fontSize:40.0))),
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Container(child: LightsStateWidget()),
      ),
    );
  }
}
