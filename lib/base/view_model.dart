import 'package:flutter/material.dart';

abstract class ViewModel extends ChangeNotifier {
  BuildContext context;
  ViewModel({required this.context});
}
