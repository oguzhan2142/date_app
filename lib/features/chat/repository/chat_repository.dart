import 'package:frontend/features/chat/model/message.dart';
import 'package:frontend/model/auth.dart';
import 'package:frontend/model/user.dart';

import '../../../base/base_repository.dart';
import '../../../enums/request_type.dart';
import '../model/chat_match.dart';

class ChatRepository extends BaseRepository {
  ChatRepository({required super.requestManager});

  Future<User?> getReceiver({required int matchId}) {
    return requestManager.getSingle(
      path: '/api/chat/receiver',
      queryParameters: {
        "matchId": matchId,
        "senderId": Auth.id,
      },
      requestType: RequestType.GET,
      converter: User.fromJson,
    );
  }

  Future<List<ChatMatch>?> getMatches({required int userId}) {
    return requestManager.getList<ChatMatch>(
      queryParameters: {'userId': userId},
      path: '/api/match/matches',
      requestType: RequestType.GET,
      converter: (json) => ChatMatch.fromJson(json),
    );
  }

  Future<List<Message>?> getMessages({
    required int matchId,
    required int page,
  }) {
    return requestManager.getList<Message>(
      path: '/api/chat/messages',
      queryParameters: {
        'matchId': matchId,
        'page': page,
      },
      requestType: RequestType.GET,
      converter: (json) => Message.fromJson(json),
    );
  }
}
