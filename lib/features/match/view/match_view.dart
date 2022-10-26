import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/enums/padding_type.dart';
import 'package:frontend/features/match/provider/match_provider.dart';
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
      appBar: AppBar(),
      body: Padding(
        padding: PaddingType.PAGE.insets,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Consumer(
              builder: (context, ref, child) {
                var match = ref.watch(currentMatchProvider);

                var consumedAll = ref.watch(viewModel.consumedAllProvider);
                if (consumedAll) {
                  return const Text('You consumed all people');
                }
                if (match == null) {
                  return const CircularProgressIndicator();
                }

                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.network(
                            match.getFirstImage() ?? '',
                            errorBuilder: (context, error, stackTrace) => Assets.images.test.image(),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.center,
                                  colors: [
                                    Theme.of(context).primaryColor.withOpacity(0.5),
                                    Theme.of(context).primaryColor.withOpacity(0.01),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
