import 'package:flutter/material.dart';

import 'package:frontend/enums/padding_type.dart';
import 'package:frontend/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final ChatViewModel viewModel;

  @override
  void initState() {
    viewModel = ChatViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: PaddingType.PAGE.insets,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Matches',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 65,
              child: Consumer(
                builder: (context, ref, child) {
                  return const SizedBox();
                  // var matches = ref.watch(matchesProvider);
                  // return ListView.separated(
                  //   itemCount: matches.length,
                  //   scrollDirection: Axis.horizontal,
                  //   itemBuilder: (context, index) {
                  //     return ChatMatchListItem(
                  //       chatMatch: matches[index],
                  //       onTap: () => viewModel.navigateToChatDetail(
                  //         matches[index].userId!,
                  //       ),
                  //     );
                  //   },
                  //   separatorBuilder: (_, index) => const SizedBox(
                  //     width: 10,
                  //   ),
                  // );
                },
              ),
            ),
            const Divider(),
            Text(
              'Messages',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Expanded(
              child: Consumer(
                builder: (context, _, child) {
                  return const SizedBox();
                  // var rooms = ref.watch(roomsProvider);
                  // return ListView.builder(
                  //   itemCount: rooms.length,
                  //   itemBuilder: (context, index) {
                  //     return RoomListItem(
                  //       onTap: () => viewModel.navigateToChatDetail(
                  //         rooms[index].contact!.id!,
                  //       ),
                  //       room: rooms[index],
                  //     );
                  //   },
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
