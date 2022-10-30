import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/base/view_model.dart';
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
  final currentMatchProvider = StateProvider<MatchUser?>((ref) => null);
  Queue queue = Queue();

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
          count: 2,
        )
        .then((value) {
      if (value != null) {
        if (value.isEmpty) {
          ref.read(consumedAllProvider.state).state = true;
        }
        queue.addAll(value);
      }
      _updateCurrent();
    });
  }

  void _updateCurrent() {
    if (queue.isEmpty) {
      return;
    }
    var user = queue.removeFirst();
    ref.read(currentMatchProvider.state).state = user;
  }

  void _swipe(bool isAccepted) {
    if (Auth.isNull) {
      return;
    }

    MatchUser? targetUser = ref.read(currentMatchProvider);

    if (targetUser == null) {
      _initCurrentMatchUser();
      return;
    }

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
        }
      },
    );
    _updateCurrent();
  }
}
