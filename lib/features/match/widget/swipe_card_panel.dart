import 'package:flutter/material.dart';
import 'package:frontend/features/match/view/detail_card_view.dart';
import 'package:frontend/features/match/viewmodel/match_viewmodel.dart';
import 'package:provider/provider.dart';
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
                    Row(
                      children: [
                        Text(
                          user.firstName ?? '',
                          style: Theme.of(context).textTheme.titleMedium?.apply(
                                color: Colors.white,
                                fontSizeDelta: 8,
                                fontWeightDelta: 2,
                              ),
                        ),
                        IconButton(
                          onPressed: () {
                            final viewModel = context.read<MatchViewModel>();
                            final route = PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => DetailCardView(
                                onLike: viewModel.onLike,
                                onNope: viewModel.onNope,
                                matchUser: user,
                              ),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(0.0, 1.0);
                                const end = Offset.zero;
                                final tween = Tween(begin: begin, end: end);
                                final offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            );

                            Navigator.of(context).push(route);
                          },
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
