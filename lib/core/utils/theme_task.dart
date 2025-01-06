import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  appBarTheme: AppBarTheme(color: Colors.blueAccent),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  appBarTheme: AppBarTheme(color: Colors.black),
);
