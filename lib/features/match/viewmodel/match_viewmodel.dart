import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/base/view_model.dart';
import 'package:frontend/enums/swipe_direction.dart';
import 'package:frontend/model/auth.dart';

import '../model/match_user.dart';
import '../provider/repository_providers.dart';

class MatchViewModel extends ViewModel {
  MatchViewModel({required super.context, required super.ref});

  @override
  void init() {
    _initCurrentMatchUser();
    super.init();
  }

  final consumedAllProvider = StateProvider<bool>((ref) => false);

  final queueProvider = StateProvider<List<MatchUser>>((ref) {
    return <MatchUser>[];
  });

  void onSwipeLeft() => _swipe(SwipeDirection.LEFT);

  void onSwipeRight() => _swipe(SwipeDirection.RIGHT);

  void _addItemsToQueue(Iterable<MatchUser> users) {
    var queue = ref.read(queueProvider);

    ref.read(queueProvider.state).state = [...queue, ...users];
  }

  MatchUser? _popFirstFromQueue() {
    var queue = ref.read(queueProvider);
    if (queue.isEmpty) return null;

    var user = queue.removeAt(0);

    ref.read(queueProvider.state).state = queue;
    return user;
  }

  void _initCurrentMatchUser() {
    if (Auth.isNull) {
      return;
    }
    ref
        .read(matchRepositoryProvider)
        .getMatch(
          userId: Auth.instance!.user.id,
          count: 2,
        )
        .then((value) {
      if (value != null) {
        if (value.isEmpty) {
          ref.read(consumedAllProvider.state).state = true;
        }

        _addItemsToQueue(value);
      }
      // _updateCurrent();
    });
  }

  void _fillQueue() {
    ref
        .read(matchRepositoryProvider)
        .getMatch(
          userId: Auth.instance!.user.id,
          count: 2,
        )
        .then((value) {
      var queue = ref.read(queueProvider);
      if (value != null) {
        ref.read(queueProvider.state).state = [...queue, ...value];
      }
    });
  }

  void _swipe(SwipeDirection swipeDirection) {
    if (Auth.isNull) {
      return;
    }

    MatchUser? targetUser = _popFirstFromQueue();

    if (targetUser == null) {
      _fillQueue();
      return;
    }

    ref
        .read(matchRepositoryProvider)
        .postMach(
          userId: Auth.instance!.user.id,
          targetUserId: targetUser.id!,
          swipeDirection: swipeDirection,
        )
        .then(
      (value) {
        var queue = ref.read(queueProvider);
        if (queue.length < 3) {
          _fillQueue();
        }
      },
    );
  }
}
