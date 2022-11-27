import 'package:flutter/material.dart';
import 'package:frontend/manager/theme/colors.dart';
import 'package:frontend/manager/theme/primary_swatch.dart';

class ThemeManager {
  static final ThemeManager instance = ThemeManager._();
  ThemeManager._();

  final lightTheme = ThemeData(
    primarySwatch: primarySwatch,
    primaryColor: primary,
    scaffoldBackgroundColor: scaffoldBackground,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(color: gray),
    textTheme: const TextTheme(),
  );
}
