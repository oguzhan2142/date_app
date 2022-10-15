import 'package:flutter/material.dart';

enum PaddingType {
  PAGE(EdgeInsets.symmetric(horizontal: 25));

  const PaddingType(this.insets);

  final EdgeInsets insets;
}
