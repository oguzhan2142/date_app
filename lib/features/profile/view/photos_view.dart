import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants/double_consts.dart';
import 'package:frontend/features/profile/viewmodel/photos_viewmodel.dart';
import 'package:frontend/features/profile/widget/photo_list_item.dart';

class PhotosView extends ConsumerStatefulWidget {
  const PhotosView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotosViewState();
}

class _PhotosViewState extends ConsumerState<PhotosView> {
  late final PhotosViewModel viewModel;

  @override
  void initState() {
    viewModel = PhotosViewModel(context: context, ref: ref);
    super.initState();
  }

  GestureDetector _addPhoto() {
    return GestureDetector(
      onTap: viewModel.onTapNewPhoto,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(photoRadius),
          border: Border.all(width: 0.3),
        ),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, child) {
          var images = ref.watch(viewModel.imagesProvider);

          return GridView.count(
            padding: const EdgeInsets.all(10),
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: photoAspectRatio,
            //   physics: const NeverScrollableScrollPhysics(),
            children: [
              ...List.generate(
                  images.length,
                  (index) => PhotoListItem(
                        index: index,
                        onIndexChanged: viewModel.onIndexChanged,
                        orderImage: images[index],
                      )),
              if (images.length != 9) _addPhoto(),
            ],
          );
        },
      ),
    );
  }
}
