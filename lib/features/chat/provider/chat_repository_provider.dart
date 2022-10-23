import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/chat/repository/chat_repository.dart';
import 'package:frontend/features/chat/repository/i_chat_repository.dart';

import '../../../constants/string_consts.dart';
import '../../../manager/request_manager/request_manager.dart';

final chatRepositoryProvider = Provider<IChatRepository>((ref) {
  return ChatRepository(requestManager: RequestManager(baseUrl));
});
