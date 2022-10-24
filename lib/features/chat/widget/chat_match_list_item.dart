import 'package:flutter/material.dart';

import '../model/chat_match.dart';

class ChatMatchListItem extends StatelessWidget {
  final ChatMatch chatMatch;
  final VoidCallback onTap;
  const ChatMatchListItem({
    Key? key,
    required this.chatMatch,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: 30,
        backgroundImage: NetworkImage(chatMatch.image ?? ''),
      ),
    );
  }
}
