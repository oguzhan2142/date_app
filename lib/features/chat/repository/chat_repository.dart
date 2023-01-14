import 'package:frontend/features/chat/model/message.dart';

import '../../../base/base_repository.dart';
import '../../../enums/request_type.dart';
import '../model/chat_match.dart';

class ChatRepository extends BaseRepository {
  ChatRepository({required super.requestManager});

  Future<List<ChatMatch>?> getMatches({required int userId}) {
    return requestManager.getList<ChatMatch>(
      queryParameters: {'userId': userId},
      path: '/api/match/matches',
      requestType: RequestType.GET,
      converter: (json) => ChatMatch.fromJson(json),
    );
  }

  Future<List<Message>?> getMessages({
    required int userId,
    required String otherUserId,
    required int page,
  }) {
    return requestManager.getList<Message>(
      path: '/api/chat/messages',
      queryParameters: {
        'userId': userId,
        'otherUserId': otherUserId,
        'page': page,
      },
      requestType: RequestType.GET,
      converter: (json) => Message.fromJson(json),
    );
  }
}
