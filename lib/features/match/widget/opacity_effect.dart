import 'package:flutter/material.dart';

class OpacityEffect extends StatelessWidget {
  const OpacityEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.7),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
