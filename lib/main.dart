import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lite/redux/middleware.dart';
import 'package:lite/containers/config_container.dart';
import 'package:lite/models/model.dart';
import 'package:lite/redux/reducers.dart';
import 'package:lite/screens/home_page.dart';
import 'package:lite/util/color_palette_utility.dart';
import 'package:lite/util/environment_utility.dart';
import 'package:lite/util/network.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

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

    final Store<AppState> store = Store<AppState>(
      appStateReducer,
      initialState: AppState.initialState(),
      middleware: [thunkMiddleware, ExtraArgumentThunkMiddleware(String)]
    );

    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Lite',
          home: HomePage(),
          routes: {
            HomePage.routeName: (ctx) => HomePage(),
            ConfigContainer.routeName: (ctx) => ConfigContainer(),
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
