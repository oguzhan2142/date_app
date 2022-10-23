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
}
