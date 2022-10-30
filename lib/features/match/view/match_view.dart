import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/features/match/model/match_user.dart';
import 'package:frontend/features/match/viewmodel/match_viewmodel.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

import '../widget/clickable_image.dart';

class MatchView extends ConsumerStatefulWidget {
  const MatchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchViewState();
}

class _MatchViewState extends ConsumerState<MatchView> {
  late final MatchViewModel viewModel;
  final SwipeableCardSectionController cardController = SwipeableCardSectionController();
  @override
  void initState() {
    viewModel = MatchViewModel(context: context, ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var consumedAll = ref.watch(viewModel.consumedAllProvider);
    if (consumedAll) {
      return const Text('You consumed all people');
    }

    var match = ref.watch(viewModel.currentMatchProvider);

    print(match?.firstName);

    return Scaffold(
      appBar: AppBar(),
      body: match == null
          ? const SizedBox()
          : SwipableStack(
              onSwipeCompleted: (index, direction) {
                if (direction == SwipeDirection.right) {
                  viewModel.onSwipeRight();
                } else if (direction == SwipeDirection.left) {
                  viewModel.onSwipeLeft();
                }
              },
              builder: (context, properties) {
                return ClickableImage(
                  matchUser: match,
                  leftPressed: () {
                    viewModel.onSwipeLeft();
                  },
                  rightPressed: () {
                    viewModel.onSwipeRight();
                  },
                );
              },
            ),
    );
  }

  List<ClickableImage> matchesToWidgets(List<MatchUser> matches) {
    return matches
        .map((e) => ClickableImage(
              matchUser: e,
              leftPressed: () {
                //
              },
              rightPressed: () {
                //
              },
            ))
        .toList();
  }
}
