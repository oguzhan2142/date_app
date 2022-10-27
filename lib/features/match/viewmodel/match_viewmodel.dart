import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/base/view_model.dart';
import 'package:frontend/model/auth.dart';

import '../model/match_user.dart';
import '../provider/match_provider.dart';
import '../provider/repository_providers.dart';

class MatchViewModel extends ViewModel {
  MatchViewModel({required super.context, required super.ref}) {
    _initCurrentMatchUser();
  }
  final consumedAllProvider = StateProvider<bool>((ref) => false);

  final imageIndexProvider = StateProvider<int>((ref) => 0);

  final queue = Queue<MatchUser>();

  void onSwipeLeft() => _swipe(false);

  void onSwipeRight() => _swipe(true);

  void _initCurrentMatchUser() {
    if (Auth.isNull) {
      return;
    }
    ref
        .read(apiRepositoryProvider)
        .getMatch(
          userId: Auth.instance!.user.id,
          count: 1,
        )
        .then((value) {
      if (value != null) {
        print(value);
        if (value.isEmpty) {
          ref.read(consumedAllProvider.state).state = true;
        }
        queue.addAll(value);
        _updateCurrent();
      }
    });
  }

  void _swipe(bool isAccepted) {
    if (Auth.isNull) {
      return;
    }

    MatchUser? targetUser = ref.read(currentMatchProvider.state).state;

    if (targetUser == null) {
      _initCurrentMatchUser();
      return;
    }
    ref.read(currentMatchProvider.state).state = null;
    ref
        .read(apiRepositoryProvider)
        .getMatch(
          userId: Auth.instance!.user.id,
          targetUserId: targetUser.id,
          count: 2,
          isAccepted: isAccepted,
        )
        .then(
      (value) {
        if (value != null) {
          queue.addAll(value);
          _updateCurrent();
        }
      },
    );
  }

  void _updateCurrent() {
    if (queue.isEmpty) {
      return;
    }
    var user = queue.removeFirst();
    ref.read(currentMatchProvider.state).state = user;
  }

  int _imagesLength() {
    var match = ref.read(currentMatchProvider);
    return match?.images?.length ?? 0;
  }

  void increaseIndex() {
    var index = ref.read(imageIndexProvider);

    if (index >= _imagesLength() - 1) {
      return;
    }
    ref.read(imageIndexProvider.state).state = index + 1;
  }

  void decreaseIndex() {
    var index = ref.read(imageIndexProvider);

    if (index <= 0) {
      return;
    }

    ref.read(imageIndexProvider.state).state = index - 1;
  }
}
