import 'package:flutter/material.dart';
import 'package:frontend/constants/double_consts.dart';
import 'package:frontend/features/profile/model/order_image.dart';

class PhotoListItem extends StatelessWidget {
  PhotoListItem({
    required this.index,
    required this.onIndexChanged,
    required this.orderImage,
  }) : super(key: ValueKey(orderImage));

  final int index;
  final OrderImage orderImage;
  final void Function(int oldIndex, int newIndex) onIndexChanged;

  Widget _buildChild() {
    if (orderImage.isMemory) {
      if (orderImage.bytes == null) return const SizedBox();
      return Image.memory(
        orderImage.bytes!,
      );
    }

    if (orderImage.url == null) return const SizedBox();
    return Image.network(
      orderImage.url!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(photoRadius),
          child: LongPressDraggable<int>(
            data: index,
            childWhenDragging: _buildChild(),
            feedback: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(photoRadius),
                child: _buildChild(),
              ),
            ),
            child: DragTarget<int>(
              onAccept: (data) {
                onIndexChanged(index, data);
              },
              builder: (context, candidateData, rejectedData) {
                return _buildChild();
              },
            ),
          ),
        );
      },
    );
  }
}