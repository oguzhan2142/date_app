import 'package:flutter/material.dart';

import 'package:frontend/enums/padding_type.dart';
import 'package:frontend/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:provider/provider.dart';

import '../widget/chat_match_list_item.dart';
import '../widget/room_list_item.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final ChatViewModel viewModel;

  @override
  void initState() {
    viewModel = ChatViewModel(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: PaddingType.PAGE.insets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Yeni Eşleşmeler',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 65,
                child: Consumer(
                  builder: (context, ref, child) {
                    var matches = viewModel.chatMatches;
                    if (matches == null) {
                      return const SizedBox();
                    }
                    return ListView.separated(
                      itemCount: matches.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ChatMatchListItem(
                          chatMatch: matches[index],
                          onTap: () => viewModel.navigateToChatDetail(
                            matches[index].userId!,
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => const SizedBox(
                        width: 10,
                      ),
                    );
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
                    var rooms = viewModel.rooms;
                    if (rooms == null) {
                      return const SizedBox();
                    }
                    return ListView.builder(
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        return RoomListItem(
                          onTap: () => viewModel.navigateToChatDetail(
                            rooms[index].contact!.id!,
                          ),
                          room: rooms[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
