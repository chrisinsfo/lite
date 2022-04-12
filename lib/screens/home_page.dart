import 'package:flutter/material.dart';
import 'package:lite/containers/config_container.dart';
import 'package:lite/containers/devices_container.dart';
import 'package:lite/util/app_bar_dimension.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-page';

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.network_wifi),
            onPressed: () =>
                Navigator.pushNamed(context, ConfigContainer.routeName)),
      ],
      backgroundColor: Colors.black87,
      title: Align(
          alignment: Alignment.topLeft,
          child: Text('Lite', textAlign: TextAlign.left, style: TextStyle(fontSize:40.0))),
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: Colors.black87,
        body: AppBarDimension(height: appBar.preferredSize.height,
          child: SingleChildScrollView(
            child: DevicesContainer(),
          ),
        ),
      ),
    );
  }
}
