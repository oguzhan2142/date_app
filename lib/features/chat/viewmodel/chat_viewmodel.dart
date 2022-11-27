import 'package:frontend/base/view_model.dart';
import 'package:frontend/features/chat/repository/i_chat_repository.dart';
import 'package:frontend/interface/authenticated.dart';
import 'package:provider/provider.dart';

import '../model/chat_match.dart';
import '../model/room.dart';

class ChatViewModel extends ViewModel with IAuthenticated {
  late final IChatRepository chatRepository;

  List<Room>? rooms;
  List<ChatMatch>? chatMatches;

  ChatViewModel({required super.context}) {
    chatRepository = Provider.of<IChatRepository>(context, listen: false);
    _initMatches();
    _initRooms();
  }

  void _initRooms() async {
    rooms = await chatRepository.getRooms(userId: id);
    notifyListeners();
  }

  void _initMatches() async {
    chatMatches = await chatRepository.getMatches(userId: id);
    notifyListeners();
  }

  void navigateToChatDetail(String otherUserId) {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(
    //   builder: (context) => ChatDetailView(
    //     otherUserId: otherUserId,
    //   ),
    // ))
    //     .whenComplete(() {
    //   _initRooms();
    //   _initMatches();
    // });
  }
}
