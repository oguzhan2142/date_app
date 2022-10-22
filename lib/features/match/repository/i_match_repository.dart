import '../model/match_user.dart';

abstract class IMatchRepository {
  Future<List<MatchUser>?> getMatch({
    required String userId,
    required int count,
    String? targetUserId,
    bool? isAccepted,
  });
}
