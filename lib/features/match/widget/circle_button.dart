import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final Color iconColor;

  const CircleButton({
    Key? key,
    required this.onPressed,
    required this.iconData,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 2,
          )
        ],
      ),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.white,
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            iconData,
            color: iconColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
