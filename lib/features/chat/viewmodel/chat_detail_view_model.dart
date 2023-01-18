import 'package:frontend/features/chat/repository/chat_repository.dart';
import 'package:frontend/model/user.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

import '../../../base/view_model.dart';
import '../../../constants/string_consts.dart';
import '../../../model/auth.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatDetailViewModel extends ViewModel {
  final int matchId;
  final int receiverId;

  late final ChatRepository _chatRepository;

  ChatDetailViewModel({
    required super.context,
    required this.matchId,
    required this.receiverId,
  }) {
    _chatRepository = Provider.of<ChatRepository>(context, listen: false);
    init();
  }

  late final String url;
  late IO.Socket socket;
  late final types.User sender;
  late final types.User receiver;

  final _uuid = const Uuid();

  int _page = 0;
  bool _isFetching = false;
  bool initializing = false;
  User? receiverUser;
  List<types.Message> messages = [];

  bool isLastPage = false;

  String _generateRandomMessageId() => _uuid.v4();

  Future<void> _initReceiver() async {
    receiverUser = await _chatRepository.getReceiver(matchId: matchId);
  }

  void _setInitializing(bool value) {
    initializing = value;
    notifyListeners();
  }

  void _setLastPage(bool value) {
    isLastPage = value;
    notifyListeners();
  }

  void init() async {
    _setInitializing(true);
    await _initReceiver();
    if (receiverUser == null) {
      _setInitializing(false);
      return;
    }

    url = "$baseUrl?senderId=${Auth.instance!.user.id}&receiverId=$receiverId&matchId=$matchId";
    socket = IO.io(url, OptionBuilder().setTransports(['websocket']).build());

    _initUsers();

    socket.on('message', (data) {
      var message = types.TextMessage(
        author: receiver,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: _generateRandomMessageId(),
        text: data,
      );

      _addMessage(message);
    });

    socket.connect();
    await onEndReached();
    _setInitializing(false);
    // ref.read(isInitializedProvider.state).state = true;
  }

  void _initUsers() {
    sender = types.User(
      id: Auth.instance!.user.id.toString(),
      firstName: Auth.instance!.user.firstName,
      lastName: Auth.instance!.user.lastName,
    );

    receiver = types.User(
      id: receiverUser!.id.toString(),
      firstName: receiverUser!.firstName,
      lastName: receiverUser!.lastName,
    );
  }

  void _addMessage(types.Message message) {
    // var messages = ref.read(messagesProvider);

    // ref.read(messagesProvider.state).state = [message, ...messages];

    messages.insert(0, message);
    notifyListeners();
  }

  void onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: sender,
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

    var fetchedMessages = await _chatRepository.getMessages(
      matchId: matchId,
      page: _page,
    );
    if (fetchedMessages == null) {
      return;
    }
    if (fetchedMessages.isEmpty) {
      _setLastPage(true);
      return;
    }
    var models = fetchedMessages
        .map((e) => types.TextMessage(
              id: e.id!.toString(),
              author: e.senderUserId == receiverId ? receiver : sender,
              text: e.content!,
              createdAt: DateTime.tryParse(e.date ?? '')?.millisecondsSinceEpoch,
            ))
        .toList();

    messages = [...messages, ...models];
    notifyListeners();

    _isFetching = false;
  }
}
