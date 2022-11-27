import 'package:flutter/material.dart';

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
    viewModel = MatchViewModel(context);
    super.initState();
  }

  Widget _buttons(MatchViewModel viewModel) {
    return Consumer(
      builder: (context, value, child) {
        SwipeItem? swipeItem = viewModel.matchEngine.currentItem;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    // var consumedAll = ref.watch(viewModel.consumedAllProvider);
    // if (consumedAll) {
    //   return const Center(child: Text('You consumed all people'));
    // }

    // var match = ref.watch(viewModel.currentMatchProvider);

    // print(match?.firstName);
    // var queue = ref.watch(viewModel.queueProvider);

    return ChangeNotifierProvider<MatchViewModel>(
      create: (context) => viewModel,
      child: Scaffold(
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

//  if (users.isEmpty) {
//               return const SizedBox();
//             }
//             return SwipableStack(
//               itemCount: users.length,
//               onSwipeCompleted: (index, direction) {
//                 // viewModel.onSwipeRight();
//                 // print("queue size: ${queue.length}");
//                 // print('$index, $direction');
//               },
//               controller: value.swipableStackController,
//               builder: (context, swipeProperty) {
//                 var index = value.swipableStackController.currentIndex % users.length;
//                 print("stack index: $index");
//                 var item = users[index];
//                 return ExampleCard(
//                   name: item.firstName ?? '',
//                   assetPath: item.getFirstImage(),
//                 );
//               },
//             );
//   List<ClickableImage> matchesToWidgets(List<MatchUser> matches) {
//     return matches
//         .map((e) => ClickableImage(
//               matchUser: e,
//               leftPressed: () {
//                 //
//               },
//               rightPressed: () {
//                 //
//               },
//             ))
//         .toList();
//   }
// }
