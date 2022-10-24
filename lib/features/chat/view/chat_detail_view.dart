import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/chat/viewmodel/chat_detail_view_model.dart';
import 'package:frontend/gen/assets.gen.dart';

class ChatDetailView extends ConsumerStatefulWidget {
  final String otherUserId;
  const ChatDetailView({super.key, required this.otherUserId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends ConsumerState<ChatDetailView> {
  late final ChatDetailViewModel viewModel;

  @override
  void initState() {
    viewModel = ChatDetailViewModel(
      context: context,
      ref: ref,
      otherUserId: widget.otherUserId,
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
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, child) {
          var messages = ref.watch(viewModel.messagesProvider);
          var isLastPage = ref.watch(viewModel.lasPageProvider);

          var isInitialized = ref.watch(viewModel.isInitializedProvider);

          if (!isInitialized) {
            return const SizedBox();
          }
          return Chat(
            showUserAvatars: true,
            showUserNames: true,
            avatarBuilder: (userId) {
              return CircleAvatar(
                backgroundImage: AssetImage(Assets.icons.userPlaceholder.path),
              );
            },
            isLastPage: isLastPage,
            messages: messages,
            onEndReached: viewModel.onEndReached,
            onSendPressed: viewModel.onSendPressed,
            user: viewModel.userModel,
          );
        },
      ),
    );
  }
}
