import 'package:frontend/base/base_repository.dart';
import 'package:frontend/features/chat/model/room.dart';
import 'package:frontend/features/chat/repository/i_chat_repository.dart';

class ChatRepository extends BaseRepository implements IChatRepository {
  ChatRepository({required super.requestManager});

  @override
  Future<List<Room>?> getRooms({required String userId}) {
    // TODO: implement getRooms
    throw UnimplementedError();
  }
}
