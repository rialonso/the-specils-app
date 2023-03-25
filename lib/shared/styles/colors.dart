import 'package:flutter/material.dart';

final ThemeData defaultColorsTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
);
//primaryColorBrightness: Brightness.light,
//     accentColor: DefaultColors.purpleBrand,
//     primarySwatch: Colors.deepPurple,
//     accentColorBrightness: Brightness.light
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
  static const _greyMediumOpacity65 = 0xA656504C;

  static const MaterialColor greyMedium = MaterialColor(
    _greyMedium,
    <int, Color>{
      500: Color(_greyMedium),
      1: Color(_greyMediumOpacity65),
    },
  );
  static const _greySoft = 0xFFC4C4C4;

  static const MaterialColor greySoft = MaterialColor(
    _greySoft,
    <int, Color>{
      500: Color(_greySoft),
    },
  );
  static const _greenSoft = 0xFF63D4BF;
  static const _greenSoftHover = 0xD963D4BF;

  static const MaterialColor greenSoft = MaterialColor(
      _greenSoft,
    <int, Color>{
      500: Color(_greenSoft),
      300: Color(_greenSoftHover),
    },
  );
  static const _redDefault = 0xFFBA454C;

  static const MaterialColor redDefault = MaterialColor(
    _redDefault,
    <int, Color>{
      500: Color(_redDefault),
    },
  );

  static const _redSoft = 0xFFFF8B8B;
  static const MaterialColor redSoft = MaterialColor(
    _redSoft,
    <int, Color>{
      500: Color(_redSoft),
    },
  );
}
