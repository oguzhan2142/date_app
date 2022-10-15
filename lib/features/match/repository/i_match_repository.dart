import '../model/match_user.dart';

abstract class IMatchRepository {
  Future<MatchUser?> getNextMatchUser({
    required String userId,
    String? targetUserId,
    bool? isAccepted,
  });
}
