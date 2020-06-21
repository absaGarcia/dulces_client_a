/*
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `500` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */

import 'package:flutter/material.dart';

final ThemeData CompanyThemeData = new ThemeData(
  brightness: Brightness.dark,
  primarySwatch: CompanyColors.black,
  primaryColor: CompanyColors.black[50],
  primaryColorBrightness: Brightness.light,
  accentColor: CompanyColors.black[500],
  accentColorBrightness: Brightness.light,

  fontFamily: 'Montserrat',
  
);
  
class CompanyColors {
  CompanyColors._(); // this basically makes it so you can instantiate this class
   static const _blackPrimaryValue = 0xFF563c3b;

  static const MaterialColor black = const MaterialColor(
    _blackPrimaryValue,
    const <int, Color>{
      50:  const Color(0xFFFFD54F),
      100: const Color(0xFFFFECB3),
      200: const Color(0xFFFFE082),
      300: const Color(0x1F000000),
      400: const Color(0xFFbd8740),
      500: const Color(_blackPrimaryValue),
      600: const Color(0xFFbca27f),
      700: const Color(0xFF4d4d4d),
      800: const Color(0xFF4d4d4d),
      900: const Color(0xFF4d4d4d),
    },
  );
}