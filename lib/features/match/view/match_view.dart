import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/constants/double_consts.dart';
import 'package:frontend/enums/padding_type.dart';
import 'package:frontend/features/match/provider/match_provider.dart';
import 'package:frontend/features/match/viewmodel/match_viewmodel.dart';
import 'package:frontend/features/match/widget/clickable_image.dart';

import '../model/match_user.dart';
import '../widget/circle_button.dart';
import '../widget/line_indicator.dart';

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

  Widget _buttonsAndInformation(BuildContext context, MatchUser? match) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${match?.firstName}',
            style: Theme.of(context).textTheme.titleMedium?.apply(
                  color: Colors.white,
                  fontWeightDelta: 8,
                ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                '${match?.getDistance()} km uzakta',
                style: Theme.of(context).textTheme.titleSmall?.apply(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleButton(
                onPressed: viewModel.onSwipeLeft,
                iconData: Icons.close,
                iconColor: Colors.red,
              ),
              CircleButton(
                onPressed: viewModel.onSwipeLeft,
                iconData: Icons.star,
                iconColor: Colors.amber,
              ),
              CircleButton(
                onPressed: viewModel.onSwipeRight,
                iconData: Icons.favorite,
                iconColor: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _opacityEffect(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [
            Colors.black.withOpacity(1),
            Colors.black.withOpacity(0.02),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: PaddingType.PHOTO.insets,
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
                  return const Center(child: CircularProgressIndicator());
                }

                var imageIndex = ref.watch(viewModel.imageIndexProvider);

                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          AspectRatio(
                            aspectRatio: photoAspectRatio,
                            child: ClickableImage(
                              url: match.images?[imageIndex].url ?? '',
                              leftPressed: viewModel.decreaseIndex,
                              rightPressed: viewModel.increaseIndex,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: _opacityEffect(context),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 0,
                            right: 0,
                            child: _buttonsAndInformation(context, match),
                          ),
                          Positioned(
                            top: 15,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: LineIndicator(
                                size: match.images?.length ?? 0,
                                index: imageIndex,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
