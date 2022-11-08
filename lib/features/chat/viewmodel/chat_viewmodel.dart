import 'package:frontend/base/view_model.dart';

class ChatViewModel extends ViewModel {
  ChatViewModel();

  @override
  void init() {
    _initMatches();

    _initRooms();

    super.init();
  }

  void _initRooms() {
    // ref
    //     .read(chatRepositoryProvider)
    //     .getRooms(
    //       userId: Auth.instance!.user.id,
    //     )
    //     .then((value) {
    //   if (value != null) {
    //     ref.read(roomsProvider.state).state = value;
    //   }
    // });
  }

  void _initMatches() {
    // ref
    //     .read(chatRepositoryProvider)
    //     .getMatches(
    //       userId: Auth.instance!.user.id,
    //     )
    //     .then((value) {
    //   if (value != null) {
    //     ref.read(matchesProvider.state).state = value;
    //   }
    // });
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
