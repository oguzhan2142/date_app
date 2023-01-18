import 'package:frontend/enums/request_type.dart';
import 'package:frontend/enums/swipe_direction.dart';
import 'package:frontend/features/match/model/match_user.dart';
import 'package:frontend/base/base_repository.dart';

abstract class IMatchRepository {
  Future<List<MatchUser>?> getMatch({
    required int userId,
    required int count,
  });
  Future<bool> postMach({
    required int userId,
    required int targetUserId,
    required Swipe swipeDirection,
  });
}

class MatchRepository extends BaseRepository implements IMatchRepository {
  MatchRepository({required super.requestManager});

  @override
  Future<List<MatchUser>?> getMatch({
    required int userId,
    required int count,
  }) {
    return requestManager.getList(
      path: '/api/match/nearby',
      requestType: RequestType.GET,
      queryParameters: {
        'userId': userId,
        'count': count,
      },
      converter: (json) => MatchUser.fromJson(json),
    );
  }

  @override
  Future<bool> postMach({
    required int userId,
    required int targetUserId,
    required Swipe swipeDirection,
  }) {
    return requestManager.getResult(
      path: '/api/match/',
      requestType: RequestType.POST,
      body: {
        "userId": userId,
        "swipeDirection": swipeDirection.apiArg,
        "targetUserId": targetUserId,
      },
    );
  }
}
