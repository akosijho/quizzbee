import 'package:flutter/material.dart';
import 'package:game_challenger/utils/my_colors.dart';

class AppThemes {
  static ThemeData dark = ThemeData(
    fontFamily: "rimouski",
    scaffoldBackgroundColor: MyColors.scaffoldBg,
    primaryColor: MyColors.primary,
    //primaryColor: Colors.black,
    brightness: Brightness.dark,
    secondaryHeaderColor: const Color(0xFF33363C),
    buttonTheme: const ButtonThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minWidth: 10,
        height: 10),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
        displayLarge: const TextStyle(
            fontSize: 50,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: Colors.white),
        titleLarge: TextStyle(
            color: Colors.white.withOpacity(
              0.8,
            ),
            height: 1.6,
            fontSize: 12),
        headlineMedium: TextStyle(
            color: Colors.white.withOpacity(
              0.8,
            ),
            decoration: TextDecoration.underline,
            height: 1.6,
            fontSize: 12),
        headlineSmall: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            color: Colors.white),
        bodyLarge: const TextStyle(
            fontSize: 16,
            height: 1.5,
            fontWeight: FontWeight.w600,
            color: Colors.white),
        labelLarge: TextStyle(
          color: Colors.white.withOpacity(
            0.8,
          ),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: const TextStyle(
            fontSize: 32,
            height: 1.25,
            fontWeight: FontWeight.w700,
            color: Colors.white)),
    bottomAppBarTheme: const BottomAppBarTheme(color: MyColors.black),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return MyColors.primary;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return MyColors.primary;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return MyColors.primary;
        }
        return null;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return MyColors.primary;
        }
        return null;
      }),
    ),
  );

  static ThemeData light = ThemeData(
    fontFamily: "rimouski",
    scaffoldBackgroundColor: Colors.white,
    disabledColor: MyColors.myGray,
    brightness: Brightness.light,
    primaryColor: MyColors.blue1,
    secondaryHeaderColor: const Color(0xFFFFFAF6),
    dividerColor: MyColors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.topAppBarBackgroundColor,
    ),
    splashColor: MyColors.yellow.withOpacity(0.1),
    highlightColor: MyColors.yellow,
    hoverColor: MyColors.myGray.withOpacity(0.1),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      fillColor: MyColors.scaffoldBg,
    ),
    buttonTheme: const ButtonThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minWidth: 10,
        height: 10),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      // profile page
      displayLarge: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w700, color: MyColors.black),
      displaySmall: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: MyColors.scaffoldBg,
      ),
      labelLarge: TextStyle(
        color: const Color(0xFF1F232A).withOpacity(
          0.8,
        ),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: const TextStyle(
          color: MyColors.scaffoldBg,
          fontSize: 24,
          fontWeight: FontWeight.bold),
      titleLarge: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: MyColors.blue2,
      ),
      headlineSmall: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w700, color: MyColors.black),
      //pet_item list
      bodyLarge: const TextStyle(fontSize: 12, color: MyColors.myGray),
      //appointment_list
      bodyMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: MyColors.scaffoldBg),
      displayMedium: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: MyColors.scaffoldBg),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: MyColors.blue2.withOpacity(0.6),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return MyColors.blueButtonColor;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return MyColors.blueButtonColor;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return MyColors.blueButtonColor;
        }
        return null;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return MyColors.blueButtonColor;
        }
        return null;
      }),
    ),
  );
}
