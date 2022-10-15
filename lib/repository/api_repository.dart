import 'package:frontend/enums/request_type.dart';
import 'package:frontend/model/match_user.dart';
import 'package:frontend/repository/base_repository.dart';
import 'package:frontend/repository/i_api_repository.dart';

class ApiRepository extends BaseRepository implements IApiRepository {
  ApiRepository({required super.requestManager});

  @override
  Future<MatchUser?> getNextMatchUser({required String userId}) {
    return requestManager.getSingle(
      path: '/api/match/next',
      requestType: RequestType.GET,
      queryParameters: {'userId': userId},
      converter: (json) => MatchUser.fromJson(json),
    );
  }
}
