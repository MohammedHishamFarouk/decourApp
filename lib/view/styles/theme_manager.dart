import 'package:flutter/material.dart';

abstract class ThemeManager {
  static ThemeData getThemeData(){
    return ThemeData(
      fontFamily:"DMSerifDisplay",
      appBarTheme:const AppBarTheme(
        centerTitle: true
      ),
      textTheme:const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
      ),
      inputDecorationTheme:const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      textSelectionTheme:const TextSelectionThemeData(
          cursorColor: Colors.white
      ),textButtonTheme:const TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
        foregroundColor: WidgetStatePropertyAll<Color>(Colors.white)
      )
    ),
      iconButtonTheme:const IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white)
        ),
      ),
      bottomNavigationBarTheme:const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        selectedLabelStyle: TextStyle(fontSize: 12),

      )
    );
  }
}