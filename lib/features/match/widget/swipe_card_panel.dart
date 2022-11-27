import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../model/match_user.dart';

import 'opacity_effect.dart';

class SwipeCardPanel extends StatelessWidget {
  final SwipeItem swipeItem;
  final double height;
  final double bottomSpace;
  const SwipeCardPanel({
    super.key,
    required this.swipeItem,
    required this.height,
    required this.bottomSpace,
  });

  MatchUser? getUser() => swipeItem.content as MatchUser?;

  @override
  Widget build(BuildContext context) {
    var user = getUser();

    if (user == null) {
      return const SizedBox();
    }
    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const OpacityEffect(),
          Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.firstName ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.apply(
                            color: Colors.white,
                            fontSizeDelta: 8,
                            fontWeightDelta: 2,
                          ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${user.getDistance()} km uzakta',
                          style: Theme.of(context).textTheme.titleSmall?.apply(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: bottomSpace),
            ],
          ),
        ],
      ),
    );
  }
}
