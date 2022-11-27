import 'dart:math';

import 'package:flutter/material.dart';

import '../../../enums/swipe_direction.dart';

class DecisionLabel extends StatelessWidget {
  final Swipe swipe;
  const DecisionLabel({super.key, required this.swipe});

  String get _label => swipe == Swipe.LEFT ? 'Nope' : 'Like';
  Color get _color => swipe == Swipe.LEFT ? const Color(0xffFD3A73) : Colors.green;
  double get _angle => swipe == Swipe.LEFT ? pi * 0.15 : pi * -0.15;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _angle,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _color,
            width: 3,
          ),
        ),
        child: Center(
          child: Text(
            _label,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: _color,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
