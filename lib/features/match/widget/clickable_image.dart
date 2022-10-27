import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class ClickableImage extends StatelessWidget {
  final String url;
  final VoidCallback leftPressed;
  final VoidCallback rightPressed;

  const ClickableImage({
    Key? key,
    required this.url,
    required this.leftPressed,
    required this.rightPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          url,
          errorBuilder: (context, error, stackTrace) => Assets.images.test.image(),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: leftPressed,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: rightPressed,
              ),
            ),
          ],
        )
      ],
    );
  }
}
