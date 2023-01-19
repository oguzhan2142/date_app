import 'package:frontend/features/match/model/match_user.dart';

import 'package:frontend/model/auth.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../base/view_model.dart';
import '../../../enums/swipe_direction.dart';
import '../repository/match_repository.dart';

class MatchViewModel extends ViewModel {
  late final IMatchRepository matchRepository;

  List<SwipeItem> swipeItems = [];
  MatchEngine matchEngine = MatchEngine(swipeItems: []);

  final _fetchCount = 5;

  SlideRegion? slideRegion;

  MatchViewModel({required super.context}) {
    matchRepository = Provider.of<IMatchRepository>(context, listen: false);
    _fillQueue();
  }

  Future<void> _fillQueue() async {
    var data = await matchRepository.getMatch(userId: Auth.id!, count: _fetchCount);
    if (data != null) {
      var newItems = data.map((e) => SwipeItem(
            content: e,
            likeAction: () => _swipe(Swipe.RIGHT),
            nopeAction: () => _swipe(Swipe.LEFT),
            superlikeAction: () {},
            onSlideUpdate: (slideRegion) async {
              bool isCurrent = matchEngine.currentItem?.content == e;
              if (this.slideRegion != slideRegion && isCurrent) {
                this.slideRegion = slideRegion;
                notifyListeners();
              }

              print(slideRegion);
              return slideRegion;
            },
          ));
      var freshList = [...newItems];
      swipeItems = freshList;
      matchEngine = MatchEngine(swipeItems: swipeItems);

      notifyListeners();
    }
  }

  void onLike() {
    SwipeItem? swipeItem = matchEngine.currentItem;

    swipeItem?.likeAction!();
  }

  void onNope() {
    SwipeItem? swipeItem = matchEngine.currentItem;

    swipeItem?.nopeAction!();
  }

  void _swipe(Swipe swipeDirection) async {
    if (Auth.isNull) {
      return;
    }

    var user = matchEngine.currentItem?.content as MatchUser?;
    print('${user?.firstName} $swipeDirection');
    await matchRepository.postMach(
      userId: Auth.id!,
      targetUserId: user!.id!,
      swipeDirection: swipeDirection,
    );

    var nextUser = matchEngine.nextItem?.content as MatchUser?;

    if (nextUser == null) {
      _fillQueue();
    }
  }
}
