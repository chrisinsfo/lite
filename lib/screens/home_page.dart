import 'package:flutter/material.dart';
import 'package:lite/screens/configuration_screen.dart';
import 'package:lite/screens/device_list_screen.dart';
import 'package:lite/util/app_bar_dimension.dart';

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

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: Colors.black87,
        body: AppBarDimension(height: appBar.preferredSize.height,
          child: SingleChildScrollView(
            child: SafeArea(child: DeviceListScreen()),
          ),
        ),
      ),
    );
  }
}
