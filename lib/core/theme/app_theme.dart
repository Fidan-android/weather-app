import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    selectedIconTheme: IconThemeData(color: Colors.blue),
  ),
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: false,
  canvasColor: Colors.transparent,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF383838),
);
