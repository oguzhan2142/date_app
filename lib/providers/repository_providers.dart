import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/manager/request_manager.dart';
import 'package:frontend/repository/api_repository.dart';
import 'package:frontend/repository/i_api_repository.dart';

final apiRepositoryProvider = Provider<IApiRepository>((ref) {
  return ApiRepository(
    requestManager: RequestManager('http://localhost:3000'),
  );
});
