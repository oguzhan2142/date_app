import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class NoMatch extends StatelessWidget {
  const NoMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 30),
        Assets.svg.swipeProfiles.svg(
          width: MediaQuery.of(context).size.width * 0.7,
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'Kaydırmaya Başla',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'Diğer kullanıcılar ile eşleştiğinde burada gözükecekler ve onlara mesaj gönderebileceksin.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
