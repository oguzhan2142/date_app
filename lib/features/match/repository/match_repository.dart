import 'package:frontend/enums/request_type.dart';
import 'package:frontend/features/match/model/match_user.dart';
import 'package:frontend/base/base_repository.dart';

import 'i_match_repository.dart';

class MatchRepository extends BaseRepository implements IMatchRepository {
  MatchRepository({required super.requestManager});

  @override
  Future<MatchUser?> getNextMatchUser({
    required String userId,
    String? targetUserId,
    bool? isAccepted,
  }) {
    return requestManager.getSingle(
      path: '/api/match/',
      requestType: RequestType.POST,
      body: {
        'userId': userId,
        'targetUserId': targetUserId,
        'isAccepted': isAccepted,
      },
      converter: (json) => MatchUser.fromJson(json),
    );
  }
}
