import 'package:frontend/base/view_model.dart';
import 'package:frontend/manager/cache_manager/cache_manager.dart';
import 'package:frontend/manager/cache_manager/cache_tags.dart';
import 'package:frontend/model/auth.dart';
import 'package:go_router/go_router.dart';

import '../model/match_user.dart';
import '../provider/match_provider.dart';
import '../provider/repository_providers.dart';

class MatchViewModel extends ViewModel {
  MatchViewModel({required super.context, required super.ref}) {
    _initCurrentMatchUser();
  }

  void onSwipeLeft() => _swipe(false);

  void onSwipeRight() => _swipe(true);

  void _initCurrentMatchUser() {
    if (Auth.isNull) {
      return;
    }
    ref
        .read(apiRepositoryProvider)
        .getNextMatchUser(
          userId: Auth.instance!.user.id,
        )
        .then(
          (value) => ref.read(currentMatchProvider.state).state = value,
        );
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
        .getNextMatchUser(
          userId: Auth.instance!.user.id,
          targetUserId: targetUser.id,
          isAccepted: isAccepted,
        )
        .then(
          (value) => ref.read(currentMatchProvider.state).state = value,
        );
  }

  void signOut() {
    Auth.instance = null;
    CacheManager.instance.clear(CacheTag.AUTH);
    GoRouter.of(context).go('/login');
  }
}
