import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    colorScheme: ColorScheme(
      // primary: Color(0xFFFE3C5B),
      primary: Color(0xFF626262),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFE3C5B),
      secondary: Color(0xFF49B615),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFFE3C5B),
      background: Color(0xFF232323),
      onBackground: Color(0xFF2b2e4a),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF2b2e4a),
      error: Color(0x00000000),
      onError: Color(0xFF2b2e4a),
      brightness: Brightness.light,
    ),
    // primarySwatch: buildMaterialColor(Color(0xFFFE3C5B)),
    // primaryColorDark: Color(0xFFFC0028),
    // primaryColorLight: Color(0xFFFE9AAA),
    // backgroundColor: Color(0xFFF5f5f5),
    //fontFamily: 'Futura',
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headline1: TextStyle(
          // color: Color(0xFF1B070B),
          color: Color(0xFF2b2e4a),
          fontWeight: FontWeight.bold,
          fontSize: 36),
      headline2: TextStyle(
          color: Color(0xFF2b2e4a),
          fontWeight: FontWeight.bold,
          fontSize: 24),
      headline3: TextStyle(
          color: Color(0xFF2b2e4a),
          fontWeight: FontWeight.bold,
          fontSize: 18),
      headline4: TextStyle(
          color: Color(0xFF2b2e4a),
          fontWeight: FontWeight.bold,
          fontSize: 16),
      headline5: TextStyle(
          color: Color(0xFF2b2e4a),
          fontWeight: FontWeight.bold,
          fontSize: 14),
      headline6: TextStyle(
          color: Color(0xFF2b2e4a),
          fontWeight: FontWeight.normal,
          fontSize: 14),
      bodyText1: TextStyle(
          color: Color(0xFF2b2e4a),
          fontWeight: FontWeight.normal,
          fontSize: 12),
      bodyText2: TextStyle(
          color: Color(0xFF2b2e4a),
          fontWeight: FontWeight.normal,
          fontSize: 10),
    )
  );
}


// MaterialColor buildMaterialColor(Color color) {
//   List strengths = <double>[.05];
//   Map<int, Color> swatch = {};
//   final int r = color.red, g = color.green, b = color.blue;

//   for (int i = 1; i < 10; i++) {
//     strengths.add(0.1 * i);
//   }
//   for (var strength in strengths) {
//     final double ds = 0.5 - strength;
//     swatch[(strength * 1000).round()] = Color.fromRGBO(
//       r + ((ds < 0 ? r : (255 - r)) * ds).round(),
//       g + ((ds < 0 ? g : (255 - g)) * ds).round(),
//       b + ((ds < 0 ? b : (255 - b)) * ds).round(),
//       1,
//     );
//   }
//   return MaterialColor(color.value, swatch);
// }