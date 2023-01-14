import 'package:flutter/material.dart';

class AppNavigator {
  static final AppNavigator instance = AppNavigator._();
  AppNavigator._();

  void push(BuildContext context, Widget view) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => view,
    ));
  }
}
