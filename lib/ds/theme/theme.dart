import 'package:edu_ui_assessment/ds/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'text_theme.dart';

class TAppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Outfit',
        cupertinoOverrideTheme: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(fontFamily: 'Outfit'),
            navTitleTextStyle: TextStyle(fontFamily: 'Outfit'),
            navLargeTitleTextStyle: TextStyle(fontFamily: 'Outfit'),
            tabLabelTextStyle: TextStyle(fontFamily: 'Outfit'),
            actionTextStyle: TextStyle(fontFamily: 'Outfit'),
          ),
        ),
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          primary: Color(0xFF31F797),
          secondary: Color(0xFF67E7FF),
          surface: Color(0xFF232323),
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.white,
        ),
        textTheme: TTextTheme.light,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: ColorLight.colorPrimary,
          unselectedItemColor: ColorLight.colorOnSurface,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorLight.colorPrimary,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      );
}