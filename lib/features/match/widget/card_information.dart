import 'package:flutter/material.dart';

class CardInformation extends StatelessWidget {
  final String name;
  final String km;
  const CardInformation({
    super.key,
    required this.name,
    required this.km,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium?.apply(
                  color: Colors.black,
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
                '$km km uzakta',
                style: Theme.of(context).textTheme.titleSmall?.apply(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
