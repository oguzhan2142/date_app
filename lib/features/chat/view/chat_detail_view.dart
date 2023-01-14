import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:frontend/features/chat/viewmodel/chat_detail_view_model.dart';

import 'package:provider/provider.dart';

import '../../../gen/assets.gen.dart';

class ChatDetailView extends StatefulWidget {
  final int matchId;
  final int receiverId;
  const ChatDetailView({
    super.key,
    required this.matchId,
    required this.receiverId,
  });

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  late final ChatDetailViewModel viewModel;

  @override
  void initState() {
    viewModel = ChatDetailViewModel(
      context: context,
      matchId: widget.matchId,
      receiverId: widget.receiverId,
    );

    super.initState();
  }

  @override
  void dispose() {
    viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Consumer<ChatDetailViewModel>(
            builder: (context, ref, child) {
              if (viewModel.initializing) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return Chat(
                showUserAvatars: true,
                showUserNames: true,
                avatarBuilder: (userId) {
                  return CircleAvatar(
                    backgroundImage: AssetImage(Assets.icons.userPlaceholder.path),
                  );
                },
                isLastPage: viewModel.isLastPage,
                messages: viewModel.messages,
                onEndReached: viewModel.onEndReached,
                onSendPressed: viewModel.onSendPressed,
                user: viewModel.sender,
              );
            },
          ),
        );
      },
    );
  }
}
