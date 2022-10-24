import 'package:flutter/material.dart';
import 'package:frontend/base/view_model.dart';
import 'package:frontend/features/chat/provider/chat_repository_provider.dart';
import 'package:frontend/features/chat/provider/chat_state_providers.dart';

import '../../../model/auth.dart';
import '../view/chat_detail_view.dart';

class ChatViewModel extends ViewModel {
  ChatViewModel({required super.context, required super.ref});

  @override
  void init() {
    _initMatches();

    _initRooms();

    super.init();
  }

  void _initRooms() {
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
  }

  void _initMatches() {
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
  }

  void navigateToChatDetail(String otherUserId) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => ChatDetailView(
        otherUserId: otherUserId,
      ),
    ))
        .whenComplete(() {
      _initRooms();
      _initMatches();
    });
  }
}
