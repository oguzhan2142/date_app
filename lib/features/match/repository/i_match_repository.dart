import 'package:frontend/enums/swipe_direction.dart';

import '../model/match_user.dart';

abstract class IMatchRepository {
  Future<List<MatchUser>?> getMatch({
    required String userId,
    required int count,
  });
  Future<bool> postMach({
    required String userId,
    required String targetUserId,
    required Swipe swipeDirection,
  });
}
