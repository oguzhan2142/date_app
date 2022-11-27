import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../model/match_user.dart';
import 'card_information.dart';
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
              CardInformation(
                name: getUser()?.firstName ?? '',
                km: getUser()?.getDistance() ?? '',
              ),
              SizedBox(height: bottomSpace),
            ],
          ),
        ],
      ),
    );
  }
}
