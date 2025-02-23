import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: false, //Force Material 2 (Fixes unwanted blue/purple)
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white, // Light background
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent, // Transparent AppBar
    elevation: 4,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold), // Text & icons in black
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black, // ✅ Dark background
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.grey, // ✅ Grey AppBar
    elevation: 4, // Add slight shadow
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), // Text & icons in black
  ),
);