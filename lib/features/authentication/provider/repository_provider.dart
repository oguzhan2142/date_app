import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants/string_consts.dart';
import 'package:frontend/manager/request_manager/request_manager.dart';

import '../repository/authentication_repository.dart';
import '../repository/i_authentication_repository.dart';

final authRepositoryProvider = Provider<IAuthenticationRepository>((ref) {
  final RequestManager requestManager = RequestManager(baseUrl);
  return AuthenticationRepository(requestManager: requestManager);
});
