import 'package:flutter/material.dart';
import 'package:frontend/features/chat/view/chat_detail_view.dart';

import '../model/chat_match.dart';

class ChatMatchListItem extends StatelessWidget {
  final ChatMatch chatMatch;
  const ChatMatchListItem({
    Key? key,
    required this.chatMatch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatDetailView(chatMatch: chatMatch),
        ));
      },
      child: CircleAvatar(
        maxRadius: 30,
        backgroundImage: NetworkImage(chatMatch.image ?? ''),
      ),
    );
  }
}
