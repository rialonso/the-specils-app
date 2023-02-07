import 'package:flutter/material.dart';

final ThemeData defaultColorsTheme = ThemeData(
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    accentColor: DefaultColors.purpleBrand,
    primarySwatch: Colors.deepPurple,
    accentColorBrightness: Brightness.light
);

class DefaultColors {
  DefaultColors._(); // this basically makes it so you can instantiate this class

  static const _blueBrand = 0xFF105EF3;

  static const MaterialColor blueBrand = MaterialColor(
    _blueBrand,
    <int, Color>{
      500: Color(_blueBrand),
    },
  );
  static const _purpleBrand = 0xFF8A43F2;

  static const MaterialColor purpleBrand = MaterialColor(
    _purpleBrand,
    <int, Color>{
      500: Color(_purpleBrand),
    },
  );
  static const _greyMedium = 0xFF56504C;

  static const MaterialColor greyMedium = MaterialColor(
    _greyMedium,
    <int, Color>{
      500: Color(_greyMedium),
    },
  );
  static const _greySoft = 0xFFC4C4C4;

  static const MaterialColor greySoft = MaterialColor(
    _greySoft,
    <int, Color>{
      500: Color(_greySoft),
    },
  );
}
