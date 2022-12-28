import 'package:flutter/material.dart';
import 'package:frontend/manager/theme/colors.dart';

import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../gen/assets.gen.dart';
import '../viewmodel/match_viewmodel.dart';
import '../widget/circle_button.dart';
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

  Widget _buttons(MatchViewModel viewModel) {
    return Consumer(
      builder: (context, value, child) {
        SwipeItem? swipeItem = viewModel.matchEngine.currentItem;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleButton(
              onPressed: () {
                var currentItem = viewModel.matchEngine.currentItem;

                swipeItem?.nopeAction!();

                currentItem?.nope();
              },
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
              onPressed: () {
                var currentItem = viewModel.matchEngine.currentItem;

                swipeItem?.likeAction!();

                currentItem?.like();
              },
              iconPath: Assets.icons.heart.path,
              iconColor: Colors.green,
            ),
          ],
        );
      },
    );
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
                      bool isCurrent = viewModel.matchEngine.currentItem == viewModel.swipeItems[index];
                      return SwipeCard(
                        swipeItem: viewModel.swipeItems[index],
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
                child: _buttons(viewModel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
