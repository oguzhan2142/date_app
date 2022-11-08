import 'package:flutter/material.dart';
import 'package:frontend/constants/double_consts.dart';
import 'package:frontend/features/profile/viewmodel/photos_viewmodel.dart';
import 'package:frontend/features/profile/widget/photo_list_item.dart';
import 'package:provider/provider.dart';

class PhotosView extends StatefulWidget {
  const PhotosView({super.key});

  @override
  State<PhotosView> createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  late final PhotosViewModel viewModel;

  @override
  void initState() {
    viewModel = PhotosViewModel();
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
          // var images = ref.watch(viewModel.imagesProvider);
          var images = [];

          return GridView.count(
            padding: const EdgeInsets.all(10),
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: photoAspectRatio,
            //   physics: const NeverScrollableScrollPhysics(),
            children: [
              ...List.generate(
                  images.length,
                  (index) => PhotoListItem(
                        index: index,
                        onDeletePhoto: viewModel.onDeletePhoto,
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
