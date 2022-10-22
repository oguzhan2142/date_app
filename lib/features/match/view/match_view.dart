import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/match/provider/match_provider.dart';
import 'package:frontend/features/match/provider/state_provider.dart';
import 'package:frontend/features/match/viewmodel/match_viewmodel.dart';
import 'package:frontend/gen/assets.gen.dart';

class MatchView extends ConsumerStatefulWidget {
  const MatchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchViewState();
}

class _MatchViewState extends ConsumerState<MatchView> {
  late final MatchViewModel viewModel;

  @override
  void initState() {
    viewModel = MatchViewModel(context: context, ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: viewModel.signOut,
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Consumer(
            builder: (context, ref, child) {
              var match = ref.watch(currentMatchProvider);

              var consumedAll = ref.watch(consumedAllProvider);
              if (consumedAll) {
                return const Text('You consumed all people');
              }
              if (match == null) {
                return const CircularProgressIndicator();
              }

              return Column(
                children: [
                  Image.network(
                    match.getFirstImage() ?? '',
                    errorBuilder: (context, error, stackTrace) => Assets.icons.userPlaceholder.image(),
                  ),
                  Text(match.username ?? '-'),
                ],
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 28,
                child: IconButton(
                  onPressed: viewModel.onSwipeLeft,
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 28,
                child: IconButton(
                  onPressed: viewModel.onSwipeRight,
                  icon: const Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
