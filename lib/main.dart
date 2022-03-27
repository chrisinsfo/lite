import 'package:flutter/material.dart';
import 'package:lit/blocs/device_bloc.dart';
import 'package:lit/providers/config_provider.dart';
import 'package:lit/screens/configuration_screen.dart';
import 'package:lit/screens/home_page.dart';
import 'package:lit/util/color_palette_utility.dart';
import 'package:provider/provider.dart';

import 'package:lit/util/environment_utility.dart';
import 'package:lit/util/network.dart';
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
        ChangeNotifierProvider.value(value: DeviceBloc()),
        ChangeNotifierProvider.value(value: ConfigProvider())
      ],
      child: MaterialApp(
        title: 'Lit',
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
