import 'package:frontend/features/chat/model/message.dart';
import 'package:frontend/model/user.dart';

import '../../../base/base_repository.dart';
import '../../../enums/request_type.dart';
import '../model/room.dart';
import '../model/chat_match.dart';

import 'i_chat_repository.dart';

class ChatRepository extends BaseRepository implements IChatRepository {
  ChatRepository({required super.requestManager});

  @override
  Future<List<Room>?> getRooms({required String userId}) {
    return requestManager.getList(
      path: '/api/chat',
      queryParameters: {'userId': userId},
      requestType: RequestType.GET,
      converter: (json) => Room.fromJson(json),
    );
  }

  @override
  Future<List<ChatMatch>?> getMatches({required String userId}) {
    return requestManager.getList<ChatMatch>(
      queryParameters: {'userId': userId},
      path: '/api/match/matches',
      requestType: RequestType.GET,
      converter: (json) => ChatMatch.fromJson(json),
    );
  }

  @override
  Future<List<Message>?> getMessages({
    required String userId,
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

  @override
  Future<User?> getUserById({required String userId}) {
    return requestManager.getSingle(
      path: '/api/chat/user/$userId',
      requestType: RequestType.GET,
      converter: (json) => User.fromJson(json),
    );
  }
}
