import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/chat/provider/chat_repository_provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

import '../../../base/view_model.dart';
import '../../../constants/string_consts.dart';
import '../../../model/auth.dart';
import '../model/chat_match.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatDetailViewModel extends ViewModel {
  final ChatMatch chatMatch;
  final messagesProvider = StateProvider<List<types.Message>>((ref) {
    return [];
  });
  final lasPageProvider = StateProvider<bool>((ref) {
    return false;
  });

  ChatDetailViewModel({
    required super.context,
    required super.ref,
    required this.chatMatch,
  });

  late final String url;
  late IO.Socket socket;
  late final types.User user;
  late final types.User otherUser;

  final _uuid = const Uuid();

  int _page = 0;
  bool _isFetching = false;

  String _generateRandomMessageId() => _uuid.v4();
  @override
  void init() {
    url = "$baseUrl?userId=${Auth.instance!.user.id}&otherUserId=${chatMatch.userId}";
    socket = IO.io(url, OptionBuilder().setTransports(['websocket']).build());

    user = types.User(id: Auth.instance!.user.id);
    otherUser = types.User(
      id: chatMatch.userId!,
      firstName: chatMatch.firstName,
      lastName: chatMatch.lastName,
    );

    socket.on('message', (data) {
      var message = types.TextMessage(
        author: otherUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: _generateRandomMessageId(),
        text: data,
      );

      _addMessage(message);
    });

    socket.connect();
    onEndReached();
    super.init();
  }

  void _addMessage(types.Message message) {
    var messages = ref.read(messagesProvider);

    ref.read(messagesProvider.state).state = [message, ...messages];
  }

  void onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _generateRandomMessageId(),
      text: message.text,
    );

    socket.emit('message', [message.text]);

    _addMessage(textMessage);
  }

  void onDispose() {
    socket.dispose();
  }

  Future<void> onEndReached() async {
    if (_isFetching) {
      return;
    }
    _page++;
    _isFetching = true;
    var fetchedMessages = await ref.read(chatRepositoryProvider).getMessages(
          userId: Auth.instance!.user.id,
          otherUserId: chatMatch.userId!,
          page: _page,
        );
    if (fetchedMessages == null) {
      return;
    }
    if (fetchedMessages.isEmpty) {
      ref.read(lasPageProvider.state).state = true;
      return;
    }
    var models = fetchedMessages
        .map((e) => types.TextMessage(
              id: e.id!,
              author: e.userId == chatMatch.userId ? otherUser : user,
              text: e.content!,
              createdAt: DateTime.tryParse(e.createdAt ?? '')?.millisecondsSinceEpoch,
            ))
        .toList();
    var messages = ref.read(messagesProvider);

    ref.read(messagesProvider.state).state = [...messages, ...models];
    _isFetching = false;
  }
}
