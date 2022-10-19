import '../model/room.dart';

abstract class IChatRepository {
  Future<List<Room>?> getRooms({required String userId});
}
