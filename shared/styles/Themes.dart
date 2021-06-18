import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darktheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: defaultColor),
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: HexColor('333739'),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      elevation: 5,
      iconTheme: IconThemeData(color: Colors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
    elevation: 30,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);
ThemeData lighttheme = ThemeData(
    primarySwatch: defaultColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: defaultColor),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.grey[100],
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 30,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ));
