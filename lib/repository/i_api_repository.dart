import '../model/match_user.dart';

abstract class IApiRepository {
  Future<MatchUser?> getNextMatchUser({required String userId});
}
