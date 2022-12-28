import 'package:flutter/material.dart';
import 'package:frontend/manager/theme/colors.dart';
import 'package:frontend/manager/theme/primary_swatch.dart';

class ThemeManager {
  static final ThemeManager instance = ThemeManager._();
  ThemeManager._();

  final lightTheme = ThemeData(
    primarySwatch: primarySwatch,
    primaryColor: primary,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black54,
      ),
    ),
    iconTheme: const IconThemeData(color: gray),
    textTheme: const TextTheme(),
  );
}
