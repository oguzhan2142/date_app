import 'package:frontend/base/view_model.dart';
import 'package:frontend/features/chat/provider/chat_repository_provider.dart';
import 'package:frontend/features/chat/provider/chat_state_providers.dart';

import '../../../model/auth.dart';

class ChatViewModel extends ViewModel {
  ChatViewModel({required super.context, required super.ref});

  @override
  void init() {
    ref
        .read(chatRepositoryProvider)
        .getMatches(
          userId: Auth.instance!.user.id,
        )
        .then((value) {
      if (value != null) {
        ref.read(matchesProvider.state).state = value;
      }
    });

    ref
        .read(chatRepositoryProvider)
        .getRooms(
          userId: Auth.instance!.user.id,
        )
        .then((value) {
      if (value != null) {
        ref.read(roomsProvider.state).state = value;
      }
    });

    super.init();
  }
}
