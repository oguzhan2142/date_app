import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import 'circle_button.dart';

class DecisionButtons extends StatelessWidget {
  final VoidCallback onLike;
  final VoidCallback onNope;

  const DecisionButtons({
    Key? key,
    required this.onLike,
    required this.onNope,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleButton(
          onPressed: onNope,
          iconPath: Assets.icons.close.path,
          iconColor: Colors.red,
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 65,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(6),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.red,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '-12',
                      style: Theme.of(context).textTheme.bodyText1?.apply(color: Colors.red),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 65,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(6),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '100',
                      style: Theme.of(context).textTheme.bodyText1?.apply(color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        CircleButton(
          onPressed: onLike,
          iconPath: Assets.icons.heart.path,
          iconColor: Colors.green,
        ),
      ],
    );
  }
}
