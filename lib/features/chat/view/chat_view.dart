import 'package:flutter/material.dart';

import 'package:frontend/enums/padding_type.dart';
import 'package:frontend/features/chat/view/chat_detail_view.dart';
import 'package:frontend/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:frontend/features/chat/widget/no_match.dart';
import 'package:frontend/router/app_navigator.dart';
import 'package:provider/provider.dart';

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

  // Widget _matches() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Yeni Eşleşmeler',
  //         style: Theme.of(context).textTheme.titleSmall,
  //       ),
  //       const SizedBox(height: 5),
  //       SizedBox(
  //         height: 65,
  //         child: Consumer(
  //           builder: (context, ref, child) {
  //             var matches = viewModel.chatMatches;
  //             if (matches == null) {
  //               return const SizedBox();
  //             }
  //             return ListView.separated(
  //               itemCount: matches.length,
  //               scrollDirection: Axis.horizontal,
  //               itemBuilder: (context, index) {
  //                 return ChatMatchListItem(
  //                   chatMatch: matches[index],
  //                   onTap: () => viewModel.navigateToChatDetail(
  //                     matches[index].userId!,
  //                   ),
  //                 );
  //               },
  //               separatorBuilder: (_, index) => const SizedBox(
  //                 width: 10,
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //       const Divider(),
  //     ],
  //   );
  // }

  Widget _messages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Messages',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Expanded(
          child: Consumer(
            builder: (context, _, child) {
              var rooms = viewModel.chatMatches;
              if (rooms == null) {
                return const SizedBox();
              }
              return ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  var item = rooms[index];

                  return RoomListItem(
                    onTap: () {
                      if (item.matchId != null) {
                        AppNavigator.instance.push(
                          context,
                          ChatDetailView(
                            matchId: item.matchId!,
                            receiverId: item.userId!,
                          ),
                        );
                      }
                    },
                    room: item,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: PaddingType.PAGE.insets,
          child: Consumer<ChatViewModel>(
            builder: (context, _, child) {
              if (viewModel.isLoading) {
                return const SizedBox();
              }

              if ((viewModel.chatMatches?.isEmpty ?? false) && (viewModel.chatMatches?.isEmpty ?? false)) {
                return const NoMatch();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // if (viewModel.chatMatches?.isNotEmpty ?? false) _matches(),
                  if (viewModel.chatMatches?.isNotEmpty ?? false) Expanded(child: _messages()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
