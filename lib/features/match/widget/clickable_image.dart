import 'package:flutter/material.dart';
import 'package:frontend/features/match/model/match_user.dart';
import 'package:frontend/features/match/widget/card_information.dart';
import 'package:frontend/features/match/widget/opacity_effect.dart';

import '../../../gen/assets.gen.dart';
import 'circle_button.dart';
import 'line_indicator.dart';

class ClickableImage extends StatefulWidget {
  const ClickableImage({
    Key? key,
    required this.matchUser,
    required this.leftPressed,
    required this.rightPressed,
  }) : super(key: key);

  final VoidCallback leftPressed;
  final MatchUser matchUser;
  final VoidCallback rightPressed;

  @override
  State<ClickableImage> createState() => _ClickableImageState();
}

class _ClickableImageState extends State<ClickableImage> {
  int imageIndex = 0;
  Widget _buttonsAndInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CardInformation(
            name: widget.matchUser.firstName ?? '',
            km: widget.matchUser.getDistance(),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleButton(
                onPressed: widget.leftPressed,
                iconData: Icons.close,
                iconColor: Colors.red,
              ),
              CircleButton(
                onPressed: () {},
                iconData: Icons.star,
                iconColor: Colors.amber,
              ),
              CircleButton(
                onPressed: widget.rightPressed,
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
    if (imageIndex >= (widget.matchUser.images?.length ?? 0) - 1) {
      return;
    }

    setState(() {
      imageIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 11 / 7,
        child: Stack(
          children: [
            Image.network(
              widget.matchUser.images?[imageIndex].url ?? '',
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
            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LineIndicator(
                  size: widget.matchUser.images?.length ?? 0,
                  index: imageIndex,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
