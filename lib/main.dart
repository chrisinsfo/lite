import 'package:flutter/material.dart';
import 'package:lit/blocs/lights_bloc.dart';
import 'package:lit/screens/home_page.dart';
import 'package:lit/util/color_palette_utility.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LightsBloc()),
      ],
      child: MaterialApp(
        title: 'Lit',
        home: HomePage(),
        routes: {
          HomePage.routeName: (ctx) => HomePage(),
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
