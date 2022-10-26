import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/base/view_model.dart';
import 'package:frontend/features/profile/model/order_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PhotosViewModel extends ViewModel {
  PhotosViewModel({required super.context, required super.ref});

  final imagesProvider = StateProvider<List<OrderImage>>((ref) {
    return [];
  });

  void onTapNewPhoto() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // 7:10 crop
    if (image?.path == null) {
      return;
    }
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatio: const CropAspectRatio(ratioX: 7, ratioY: 11),
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Resize',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Resize',
          aspectRatioLockEnabled: true,
        ),
      ],
    );

    var images = ref.read(imagesProvider);
    print(image.path);
    var bytes = await croppedFile?.readAsBytes();

    if (bytes == null) {
      return;
    }
    ref.read(imagesProvider.state).state = [...images, OrderImage(bytes: bytes)];
    // showDialog(
    //   context: context,
    //   builder: (context) => Dialog(
    //     child: Image.memory(bytes),
    //   ),
    // );
  }

  void onIndexChanged(int oldIndex, int newIndex) {
    var imageList = [...ref.read(imagesProvider)];

    final element = imageList.removeAt(oldIndex);

    imageList.insert(newIndex, element);

    ref.read(imagesProvider.state).state = imageList;
  }
}
