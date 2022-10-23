import 'dart:convert';
import 'dart:math';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/chat/model/chat_match.dart';

import '../../../constants/string_consts.dart';
import '../../../model/auth.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatDetailView extends StatefulWidget {
  final ChatMatch chatMatch;
  const ChatDetailView({super.key, required this.chatMatch});

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    var url = "$baseUrl?userId=${Auth.instance!.user.id}&otherUserId=${widget.chatMatch.userId}";
    print(url);
    IO.Socket socket = IO.io(url);

    socket.onConnect((_) {
      print('connect');
    });
    socket.on('message', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }
}
