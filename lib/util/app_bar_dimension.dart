import 'package:flutter/material.dart';

class AppBarDimension extends InheritedWidget {
  AppBarDimension({ required this.height, required this.child }) : super(child: child);

  static int statusBarHeight = 20;
  double height;
  Widget child;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
