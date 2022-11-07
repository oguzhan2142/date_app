import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/features/match/model/match_user.dart';
import 'package:frontend/features/match/viewmodel/match_viewmodel.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../widget/clickable_image.dart';
import 'bottom_buttons_row.dart';
import 'card_overlay.dart';
import 'example_card.dart';

class MatchView extends ConsumerStatefulWidget {
  const MatchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchViewState();
}

class _MatchViewState extends ConsumerState<MatchView> {
  late final MatchViewModel viewModel;

  late final SwipableStackController _controller;

  void _listenController() => setState(() {});

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  void initState() {
    viewModel = MatchViewModel(context: context, ref: ref);
    _controller = SwipableStackController()..addListener(_listenController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var consumedAll = ref.watch(viewModel.consumedAllProvider);
    // if (consumedAll) {
    //   return const Center(child: Text('You consumed all people'));
    // }

    // var match = ref.watch(viewModel.currentMatchProvider);

    // print(match?.firstName);
    var queue = ref.watch(viewModel.queueProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SwipableStack(
                  detectableSwipeDirections: const {
                    SwipeDirection.right,
                    SwipeDirection.left,
                  },
                  controller: _controller,
                  stackClipBehaviour: Clip.none,
                  onSwipeCompleted: (index, direction) {
                    if (direction == SwipeDirection.left) {
                      viewModel.onSwipeRight();
                    } else if (direction == SwipeDirection.right) {
                      viewModel.onSwipeLeft();
                    }
                  },
                  horizontalSwipeThreshold: 0.8,
                  itemCount: queue.length,
                  verticalSwipeThreshold: 0.8,
                  builder: (context, properties) {
                    if (queue.isEmpty) {
                      return const Text('No user to match');
                    }

                    final itemIndex = properties.index % queue.length;

                    var matchUser = queue.elementAt(itemIndex);

                    return Stack(
                      children: [
                        ExampleCard(
                          name: matchUser.firstName ?? '',
                          assetPath: matchUser.getFirstImage(),
                        ),
                        if (properties.stackIndex == 0 && properties.direction != null)
                          CardOverlay(
                            swipeProgress: properties.swipeProgress,
                            direction: properties.direction!,
                          )
                      ],
                    );
                  },
                ),
              ),
            ),
            BottomButtonsRow(
              onSwipe: (direction) {
                _controller.next(swipeDirection: direction);
              },
              onRewindTap: _controller.rewind,
              canRewind: _controller.canRewind,
            ),
          ],
        ),
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
