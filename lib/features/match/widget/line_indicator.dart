import 'package:flutter/material.dart';

class LineIndicator extends StatelessWidget {
  final int size;
  final int index;

  const LineIndicator({
    Key? key,
    required this.size,
    required this.index,
  }) : super(key: key);

  Widget _buildLine(BuildContext context, bool isActive) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isActive ? Colors.white : Colors.black.withOpacity(0.4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        size + size - 1,
        (index) {
          if (index.isOdd) {
            return const SizedBox(width: 10);
          }
          return Expanded(
            child: _buildLine(context, index == (2 * this.index)),
          );
        },
      ),
    );
  }
}
