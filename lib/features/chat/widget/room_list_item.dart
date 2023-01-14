import 'package:flutter/material.dart';
import 'package:frontend/features/chat/model/chat_match.dart';
import 'package:frontend/gen/assets.gen.dart';
import 'package:get_time_ago/get_time_ago.dart';

class RoomListItem extends StatelessWidget {
  final ChatMatch room;
  final VoidCallback onTap;
  const RoomListItem({super.key, required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String? timeAgo;

    try {
      var date = DateTime.tryParse(room.lastMessage?.date ?? '');
      timeAgo = GetTimeAgo.parse(date!);
    } catch (e) {}
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(Assets.icons.userPlaceholder.path),
      ),
      title: Text(room.lastMessage?.content ?? ''),
      subtitle: Row(
        children: [
          Expanded(child: Text('${room.firstName} ${room.lastName}')),
          timeAgo != null ? Text(timeAgo) : const SizedBox(),
        ],
      ),
    );
  }
}
