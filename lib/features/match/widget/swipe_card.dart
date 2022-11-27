import 'package:flutter/material.dart';
import 'package:frontend/enums/swipe_direction.dart';
import 'package:frontend/features/match/widget/swipe_card_panel.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../gen/assets.gen.dart';
import '../model/match_user.dart';
import 'decision_label.dart';
import 'line_indicator.dart';

class SwipeCard extends StatefulWidget {
  const SwipeCard({
    Key? key,
    required this.swipeItem,
    required this.slideRegion,
  }) : super(key: key);

  final SlideRegion? slideRegion;
  final SwipeItem swipeItem;

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  int imageIndex = 0;

  void decreaseIndex() {
    if (imageIndex <= 0) {
      return;
    }
    setState(() {
      imageIndex = imageIndex - 1;
    });
  }

  MatchUser? getUser() => widget.swipeItem.content as MatchUser?;

  void increaseIndex() {
    if (imageIndex >= (getUser()?.images?.length ?? 0) - 1) {
      return;
    }

    setState(() {
      imageIndex++;
    });
  }

  Widget _decisionLabels() {
    if (widget.slideRegion == SlideRegion.inLikeRegion) {
      return const Positioned(
        left: 50,
        top: 30,
        child: DecisionLabel(swipe: Swipe.RIGHT),
      );
    }
    if (widget.slideRegion == SlideRegion.inNopeRegion) {
      return const Positioned(
        right: 50,
        top: 30,
        child: DecisionLabel(swipe: Swipe.LEFT),
      );
    }

    return const SizedBox();
  }

  Widget _image() {
    if (_isImagesEmpty()) {
      return Assets.icons.userPlaceholder.image(
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      return Image.network(
        getUser()?.images?[imageIndex].url ?? '',
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Assets.images.test.image(),
      );
    }
  }

  bool _isImagesEmpty() => getUser()?.images?.isEmpty ?? true;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 11 / 7,
        child: Stack(
          children: [
            _image(),
            Align(
              alignment: Alignment.bottomCenter,
              child: SwipeCardPanel(
                swipeItem: widget.swipeItem,
                bottomSpace: 90,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
            if (!_isImagesEmpty())
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(onTap: decreaseIndex),
                  ),
                  Expanded(
                    child: GestureDetector(onTap: increaseIndex),
                  ),
                ],
              ),
            if (!_isImagesEmpty())
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: _lineIndicator(),
              ),
            _decisionLabels(),
          ],
        ),
      ),
    );
  }

  Widget _lineIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LineIndicator(
        size: getUser()?.images?.length ?? 0,
        index: imageIndex,
      ),
    );
  }
}
