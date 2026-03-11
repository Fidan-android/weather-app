import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
  useMaterial3: false,
  canvasColor: Colors.transparent,
  brightness: Brightness.light,
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: false,
  canvasColor: Colors.transparent,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF383838),
);
