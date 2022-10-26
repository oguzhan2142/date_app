import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/profile/repository/i_profile_repository.dart';
import 'package:frontend/features/profile/repository/profile_repository.dart';
import 'package:frontend/manager/request_manager/request_manager.dart';

import '../../../constants/string_consts.dart';

final profileRepositoryProvider = Provider<IProfileRepository>((ref) {
  return ProfileRepository(requestManager: RequestManager(baseUrl));
});
