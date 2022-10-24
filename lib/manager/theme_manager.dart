import 'package:flutter/material.dart';

class ThemeManager {
  static final ThemeManager instance = ThemeManager._();
  ThemeManager._();

  final lightTheme = ThemeData(
    textTheme: const TextTheme(),
  );
}
