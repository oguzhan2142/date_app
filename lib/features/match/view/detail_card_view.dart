import 'package:flutter/material.dart';

import 'package:frontend/features/match/model/match_user.dart';
import 'package:frontend/features/match/widget/decision_buttons.dart';

import '../../../gen/assets.gen.dart';

class DetailCardView extends StatefulWidget {
  final MatchUser? matchUser;
  final VoidCallback onLike;
  final VoidCallback onNope;
  const DetailCardView({
    Key? key,
    required this.matchUser,
    required this.onLike,
    required this.onNope,
  }) : super(key: key);

  @override
  State<DetailCardView> createState() => _DetailCardViewState();
}

class _DetailCardViewState extends State<DetailCardView> {
  @override
  Widget build(BuildContext context) {
    final photoHeight = MediaQuery.of(context).size.height * 0.55;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.matchUser?.getFirstImage() ?? '',
              height: photoHeight,
              fit: BoxFit.fitHeight,
              errorBuilder: (context, error, stackTrace) => Assets.icons.userPlaceholder.image(
                fit: BoxFit.fitHeight,
                height: photoHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    widget.matchUser?.firstName ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            const Spacer(),
            DecisionButtons(
              onLike: () {
                widget.onLike();
                Navigator.pop(context);
              },
              onNope: () {
                widget.onNope();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
