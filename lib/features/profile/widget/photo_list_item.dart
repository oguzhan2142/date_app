import 'package:flutter/material.dart';
import 'package:frontend/constants/double_consts.dart';
import 'package:frontend/features/profile/model/order_image.dart';

class PhotoListItem extends StatelessWidget {
  PhotoListItem({
    required this.index,
    required this.onIndexChanged,
    required this.orderImage,
    required this.onDeletePhoto,
  }) : super(key: ValueKey(orderImage));

  final int index;
  final void Function(int oldIndex, int newIndex) onIndexChanged;
  final void Function(String photoId) onDeletePhoto;
  final OrderImage orderImage;

  Widget _photo() {
    if (orderImage.orderImageType != OrderImageType.API) {
      if (orderImage.data == null) return const SizedBox();
      return Image.memory(
        orderImage.data,
      );
    }

    if (orderImage.data == null) return const SizedBox();
    return Image.network(
      orderImage.data.url,
    );
  }

  Widget _deleteBtn() {
    return GestureDetector(
      onTap: () {
        onDeletePhoto(orderImage.data.id);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 0.7,
              spreadRadius: 1.2,
            ),
          ],
        ),
        child: const CircleAvatar(
          radius: 15,
          child: Icon(
            Icons.close_outlined,
            size: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(photoRadius),
                child: LongPressDraggable<int>(
                  data: index,
                  childWhenDragging: _photo(),
                  feedback: SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(photoRadius),
                      child: _photo(),
                    ),
                  ),
                  child: DragTarget<int>(
                    onAccept: (data) {
                      onIndexChanged(data, index);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return _photo();
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: _deleteBtn(),
        )
      ],
    );
  }
}
