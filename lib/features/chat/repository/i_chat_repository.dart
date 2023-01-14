import 'package:frontend/model/user.dart';

import '../model/message.dart';
import '../model/room.dart';
import '../model/chat_match.dart';

abstract class IChatRepository {
  Future<List<Room>?> getRooms({required int userId});

  Future<List<ChatMatch>?> getMatches({required int userId});

  Future<List<Message>?> getMessages({
    required int userId,
    required String otherUserId,
    required int page,
  });

  Future<User?> getUserById({required int userId});
}
