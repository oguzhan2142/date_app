import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ViewModel {
  final BuildContext context;
  final WidgetRef ref;

  ViewModel({
    required this.context,
    required this.ref,
  }) {
    init();
  }

  void init() {}
}
