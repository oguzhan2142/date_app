import '../model/room.dart';
import '../model/chat_match.dart';

abstract class IChatRepository {
  Future<List<Room>?> getRooms({required String userId});

  Future<List<ChatMatch>?> getMatches({required String userId});
}
