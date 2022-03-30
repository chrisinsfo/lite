import 'package:flutter/material.dart';
import 'package:lite/blocs/device_bloc.dart';
import 'package:lite/providers/config_provider.dart';
import 'package:lite/screens/configuration_screen.dart';
import 'package:lite/screens/home_page.dart';
import 'package:lite/util/color_palette_utility.dart';
import 'package:provider/provider.dart';

import 'package:lite/util/environment_utility.dart';
import 'package:lite/util/network.dart';
import 'dart:io';

main(){
  if (EnvironmentUtility.environment() == Environment.DEVELOPMENT) {
    // bypass certificate validation
    HttpOverrides.global = DevHttpOverrides();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: DeviceBloc()),
        ChangeNotifierProvider.value(value: ConfigProvider())
      ],
      child: MaterialApp(
        title: 'Lite',
        home: HomePage(),
        routes: {
          HomePage.routeName: (ctx) => HomePage(),
          ConfigurationScreen.routeName: (ctx) => ConfigurationScreen(),
        },
        theme: ThemeData(
            primaryColor: ColorPaletteUtility.orange,
            primaryColorDark: ColorPaletteUtility.orange,
            canvasColor: ColorPaletteUtility.white,
            cardColor: ColorPaletteUtility.yellow,
            textButtonTheme: TextButtonThemeData(style: ColorPaletteUtility.textButtonStyle),
            elevatedButtonTheme: ElevatedButtonThemeData(style: ColorPaletteUtility.elevatedButtonStyle)
        ),
      ),
    );
  }
}
