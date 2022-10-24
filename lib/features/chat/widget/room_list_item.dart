import 'package:flutter/material.dart';
import 'package:frontend/gen/assets.gen.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../model/room.dart';

class RoomListItem extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;
  const RoomListItem({super.key, required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String? timeAgo;

    try {
      var date = DateTime.tryParse(room.message?.createdAt ?? '');
      timeAgo = GetTimeAgo.parse(date!);
    } catch (e) {}
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(Assets.icons.userPlaceholder.path),
      ),
      title: Text(room.contact?.name ?? ''),
      subtitle: Row(
        children: [
          Expanded(child: Text(room.message?.content ?? '')),
          timeAgo != null ? Text(timeAgo) : const SizedBox(),
        ],
      ),
    );
  }
}
