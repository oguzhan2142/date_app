import 'package:frontend/model/user.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

import '../../../base/view_model.dart';
import '../../../constants/string_consts.dart';
import '../../../model/auth.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatDetailViewModel extends ViewModel {
  final String otherUserId;

  ChatDetailViewModel({
    required super.context,
    required this.otherUserId,
  }) {
    init();
  }

  late final String url;
  late IO.Socket socket;
  late final types.User userModel;
  late final types.User otherUserModel;

  final _uuid = const Uuid();

  final int _page = 0;
  final bool _isFetching = false;
  User? otherUser;
  String _generateRandomMessageId() => _uuid.v4();

  void init() async {
    // otherUser = await ref.read(chatRepositoryProvider).getUserById(
    //       userId: otherUserId,
    //     );

    if (otherUser == null) {
      // Navigator.of(context).pop();
      return;
    }

    url = "$baseUrl?userId=${Auth.instance!.user.id}&otherUserId=$otherUserId";
    socket = IO.io(url, OptionBuilder().setTransports(['websocket']).build());

    userModel = types.User(id: Auth.instance!.user.id);
    otherUserModel = types.User(
      id: otherUser!.id,
      firstName: otherUser!.firstName,
      lastName: otherUser!.lastName,
    );

    socket.on('message', (data) {
      var message = types.TextMessage(
        author: otherUserModel,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: _generateRandomMessageId(),
        text: data,
      );

      _addMessage(message);
    });

    socket.connect();
    await onEndReached();

    // ref.read(isInitializedProvider.state).state = true;
  }

  void _addMessage(types.Message message) {
    // var messages = ref.read(messagesProvider);

    // ref.read(messagesProvider.state).state = [message, ...messages];
  }

  void onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: userModel,
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
    // if (_isFetching) {
    //   return;
    // }
    // _page++;
    // _isFetching = true;
    // var fetchedMessages = await ref.read(chatRepositoryProvider).getMessages(
    //       userId: Auth.instance!.user.id,
    //       otherUserId: otherUserId,
    //       page: _page,
    //     );
    // if (fetchedMessages == null) {
    //   return;
    // }
    // if (fetchedMessages.isEmpty) {
    //   ref.read(lasPageProvider.state).state = true;
    //   return;
    // }
    // var models = fetchedMessages
    //     .map((e) => types.TextMessage(
    //           id: e.id!,
    //           author: e.userId == otherUserId ? otherUserModel : userModel,
    //           text: e.content!,
    //           createdAt: DateTime.tryParse(e.createdAt ?? '')?.millisecondsSinceEpoch,
    //         ))
    //     .toList();
    // var messages = ref.read(messagesProvider);

    // ref.read(messagesProvider.state).state = [...messages, ...models];
    // _isFetching = false;
  }
}
