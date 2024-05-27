import 'package:flutter/material.dart';

class MyAppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
}

class MyAppColors {
  static const normalColoredWidgetTextColorDarkMode = Colors.black;
  static const normalColoredWidgetTextColorLightMode = Colors.white;
  static const normalWidgetTextColor = Colors.white;
  static const avaiableBalanceColor = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color.fromRGBO(210, 209, 254, 1),
      Color.fromRGBO(243, 203, 237, 1),
    ],
  );
  static const currentFlowcolor = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color.fromRGBO(230, 247, 241, 1),
      Color.fromRGBO(228, 243, 243, 1),
    ],
  );
}
