import 'package:frontend/enums/request_type.dart';
import 'package:frontend/model/match_user.dart';
import 'package:frontend/repository/base_repository.dart';
import 'package:frontend/repository/i_api_repository.dart';

class ApiRepository extends BaseRepository implements IApiRepository {
  ApiRepository({required super.requestManager});

  @override
  Future<MatchUser?> getNextMatchUser() {
    return requestManager.getSingle(
      path: '/api/match',
      requestType: RequestType.GET,
      queryParameters: {'userId': "6344293f3816d40cf6120609"},
      converter: (json) => MatchUser.fromJson(json),
    );
  }
}
