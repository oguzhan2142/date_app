import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants/string_consts.dart';
import 'package:frontend/manager/request_manager/request_manager.dart';

import '../repository/i_match_repository.dart';
import '../repository/match_repository.dart';

final apiRepositoryProvider = Provider<IMatchRepository>((ref) {
  return MatchRepository(requestManager: RequestManager(baseUrl));
});
