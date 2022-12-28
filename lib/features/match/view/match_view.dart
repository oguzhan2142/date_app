import 'package:flutter/material.dart';
import 'package:frontend/features/match/widget/decision_buttons.dart';
import 'package:frontend/manager/theme/colors.dart';

import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../viewmodel/match_viewmodel.dart';
import '../widget/swipe_card.dart';

class MatchView extends StatefulWidget {
  const MatchView({super.key});

  @override
  State<MatchView> createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  late final MatchViewModel viewModel;

  @override
  void initState() {
    viewModel = MatchViewModel(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MatchViewModel>(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: scaffoldBackground,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 5,
          ),
          child: Stack(
            children: [
              Consumer<MatchViewModel>(
                builder: (context, value, child) {
                  var isNull = value.matchEngine.currentItem == null;
                  if (isNull) {
                    return const SizedBox();
                  }

                  return SwipeCards(
                    matchEngine: viewModel.matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      var item = viewModel.swipeItems[index];
                      bool isCurrent = viewModel.matchEngine.currentItem == item;

                      return SwipeCard(
                        swipeItem: item,
                        slideRegion: isCurrent ? value.slideRegion : null,
                      );
                    },
                    onStackFinished: () {},
                    itemChanged: (SwipeItem item, int index) {},
                    upSwipeAllowed: false,
                    fillSpace: true,
                  );
                },
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: DecisionButtons(
                  onLike: viewModel.onLike,
                  onNope: viewModel.onNope,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
