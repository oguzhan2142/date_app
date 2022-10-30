import 'package:flutter/material.dart';

class OpacityEffect extends StatelessWidget {
  const OpacityEffect({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [
            Colors.black.withOpacity(1),
            Colors.black.withOpacity(0.02),
          ],
        ),
      ),
    );
  }
}
