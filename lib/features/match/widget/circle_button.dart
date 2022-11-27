import 'package:flutter/material.dart';

import '../../../manager/theme/colors.dart';

class CircleButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final Color iconColor;

  const CircleButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
    required this.iconColor,
  }) : super(key: key);

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        setState(() => _focused = true);
      },
      onPointerUp: (event) => setState(() => _focused = false),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 28,
          backgroundColor: _focused ? primary : Colors.white,
          child: IconButton(
            onPressed: widget.onPressed,
            icon: Image.asset(
              widget.iconPath,
              color: _focused ? Colors.white : widget.iconColor,
              width: 24,
            ),
          ),
        ),
      ),
    );
  }
}
