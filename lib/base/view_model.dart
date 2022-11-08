import 'package:flutter/material.dart';

abstract class ViewModel extends ChangeNotifier {
  ViewModel() {
    init();
  }

  void init() {}
}
