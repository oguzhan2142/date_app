import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/enums/swipe_direction.dart';
import 'package:frontend/features/match/widget/opacity_effect.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../gen/assets.gen.dart';
import '../model/match_user.dart';
import 'card_information.dart';
import 'circle_button.dart';
import 'line_indicator.dart';

class ClickableImage extends StatefulWidget {
  const ClickableImage({
    Key? key,
    required this.swipeItem,
    required this.slideRegion,
  }) : super(key: key);

  final SlideRegion? slideRegion;
  final SwipeItem swipeItem;

  @override
  State<ClickableImage> createState() => _ClickableImageState();
}

class _ClickableImageState extends State<ClickableImage> {
  int imageIndex = 0;

  MatchUser? getUser() => widget.swipeItem.content as MatchUser?;

  Widget _buttonsAndInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CardInformation(
            name: getUser()?.firstName ?? '',
            km: getUser()?.getDistance() ?? '',
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleButton(
                onPressed: () => widget.swipeItem.nopeAction!(),
                iconData: Icons.close,
                iconColor: Colors.red,
              ),
              CircleButton(
                onPressed: () {},
                iconData: Icons.star,
                iconColor: Colors.amber,
              ),
              CircleButton(
                onPressed: () => widget.swipeItem.likeAction!(),
                iconData: Icons.favorite,
                iconColor: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void decreaseIndex() {
    if (imageIndex <= 0) {
      return;
    }
    setState(() {
      imageIndex = imageIndex - 1;
    });
  }

  void increaseIndex() {
    if (imageIndex >= (getUser()?.images?.length ?? 0) - 1) {
      return;
    }

    setState(() {
      imageIndex++;
    });
  }

  @override
  void initState() {
    widget.swipeItem.addListener(() {
      print(widget.swipeItem.decision);
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ClickableImage oldWidget) {
    print(widget.swipeItem.decision);
    super.didUpdateWidget(oldWidget);
  }

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
            if (_isImagesEmpty())
              Assets.icons.userPlaceholder.image(
                fit: BoxFit.cover,
                width: double.infinity,
              )
            else
              Image.network(
                getUser()?.images?[imageIndex].url ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Assets.images.test.image(),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: OpacityEffect(
                height: MediaQuery.of(context).size.height * 0.15,
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
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: _buttonsAndInformation(context),
            ),
            if (!_isImagesEmpty())
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LineIndicator(
                    size: getUser()?.images?.length ?? 0,
                    index: imageIndex,
                  ),
                ),
              ),
            if (widget.slideRegion == SlideRegion.inLikeRegion)
              const Positioned(
                left: 50,
                top: 30,
                child: DecisionLabel(swipe: Swipe.RIGHT),
              ),
            if (widget.slideRegion == SlideRegion.inNopeRegion)
              const Positioned(
                right: 50,
                top: 30,
                child: DecisionLabel(swipe: Swipe.LEFT),
              ),
          ],
        ),
      ),
    );
  }

  bool _isImagesEmpty() => getUser()?.images?.isEmpty ?? true;
}

class DecisionLabel extends StatelessWidget {
  final Swipe swipe;
  const DecisionLabel({super.key, required this.swipe});

  String get _label => swipe == Swipe.LEFT ? 'Nope' : 'Like';
  Color get _color => swipe == Swipe.LEFT ? const Color(0xffFD3A73) : Colors.green;
  double get _angle => swipe == Swipe.LEFT ? pi * 0.15 : pi * -0.15;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _angle,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _color,
            width: 3,
          ),
        ),
        child: Center(
          child: Text(
            _label,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: _color,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
